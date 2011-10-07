# encoding:utf-8

helpers do
  def current?(page)
    '/' + page.haml_name == request.path_info
  end

  def form?(page)
    Dir['views/forms/*'].include? "views/forms/#{page}.haml"
  end

  def authenticate!(&block)
    if user = User.authenticate(params[:username], params[:password])
      yield user
    else
      @error = 'Krivo korisničko ime ili lozinka.'
      haml :login
    end
  end

  def log_in(user)
    session[:id] = user.id
  end

  def log_out
    session[:id] = nil
  end

  def logged_in?
    session[:id]
  end

  def string_to_id(string)
    string.parameterize
  end

  def cancel_pressed?
    params[:action] == 'Odustani'
  end

  def error?(column)
    @content.errors.has_key?(column)
  end

  def link_to(text, href, attributes = {})
    haml_tag :a, text, {href: href}.update(attributes)
  end

  def form_tag(form_attr, &block)
    if form_attr[:method] == 'get' or form_attr[:method] == 'post'
      haml_tag(:form, form_attr) { yield if block_given? }
    else
      haml_tag(:form, form_attr.merge(method: 'post')) do
        haml_tag(:input, {type: 'hidden', name: '_method', value: form_attr[:method]}) do
          yield if block_given?
        end
      end
    end
  end

  def buttons(buttons, link)
    buttons[:edit] = 'Izmjeni' if buttons[:edit] == true
    buttons[:delete] = 'Izbriši' if buttons[:delete] == true
    haml_tag 'ol.controls' do
      if buttons.has_key? :edit
        haml_tag :li do
          link_to(buttons[:edit], link, {:class => 'edit'})
        end
      end
      if buttons.has_key? :delete
        haml_tag :li do
          link_to(buttons[:delete], "/confirmation#{link}", {:class => 'delete'})
        end
      end
    end
  end

  def add_button(link, value = 'Dodaj +')
    haml_tag 'div.add' do
      link_to value, link
    end
  end

  def render_markdown(text)
    Redcarpet.new(text, :hard_wrap).to_html
  end
end
