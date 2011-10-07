# encoding:utf-8

helpers do
  def current?(page)
    '/' + page.haml_name == request.path_info
  end

  def form?(page)
    Dir['views/forms/*'].include? "views/forms/#{page}.haml"
  end

  def authenticate(&block)
    if user = User.authenticate(params[:username], params[:password])
      yield user
    else
      @error = 'Krivo korisničko ime ili lozinka.'
      haml :login
    end
  end

  def register(&block)
    yield User.create(:username => params[:username], :password => params[:password])
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
    if buttons[:edit].present? or buttons[:delete].present?
      haml_tag 'ol.controls' do
        if buttons.has_key? :edit
          haml_tag :li do
            link_to (buttons[:edit] == true ? 'Izmjeni' : buttons[:edit]), link, {:class => 'edit'}
          end
        end
        if buttons.has_key? :delete
          haml_tag :li do
            form_tag(action: link, method: 'delete', class: 'delete') do
              haml_tag :input, {type: 'submit', value: buttons[:delete] == true ? 'Izbriši' : buttons[:delete]}
            end
          end
        end
      end
    end

    if buttons[:add].present?
      haml_tag 'div.add' do
        link_to (buttons[:add] == true ? 'Dodaj +' : buttons[:add]), link
      end
    end
  end

    end
  end

  def render_markdown(text)
    Redcarpet.new(text, :hard_wrap).to_html
  end
end

class Time
  def to_timestamp
    self.to_s.match(/\d+\-\d+\-\d+ \d+:\d+:\d+/)[0]
  end
end
