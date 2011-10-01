# encoding:utf-8
helpers do
  def current?(page)
    '/' + page.haml_name == request.path_info
  end

  def form?(page)
    Dir['views/forms/*'].include? "views/forms/#{page}.haml"
  end

  def authenticate!(&block)
    @user = User[username: params[:username]]
    if User.empty?
      User.create(username: params[:username], password_hash: params[:password])
      yield
    elsif not @user
      @error = 'Krivo korisničko ime ili lozinka.'
      haml "forms#{request.path_info}".to_sym
    elsif @user.password_hash != BCrypt::Engine.hash_secret(params[:password], @user.password_salt)
      @error = 'Krivo korisničko ime ili lozinka.'
      haml :login
    else
      yield
    end
  end

  def log_in!
    session[:logged_in] = true
  end

  def log_out!
    session[:logged_in] = false
  end

  def logged_in?
    session[:logged_in]
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

  def edit_button(link, value = 'Izmjeni')
    haml_tag 'div.controls' do
      link_to value, link, :class => 'edit'
    end
  end

  def delete_button(link, value = 'Izbriši')
    haml_tag 'div.controls' do
      haml_tag :a, value, {:href => "/confirmation#{link}", :class => 'delete'}
    end
  end

  def edit_delete_buttons(link, values = {:edit => 'Izmjeni', :delete => 'Izbriši'})
    haml_tag 'div.controls' do
      link_to values[:edit], link, :class => 'edit'
      haml_tag :a, values[:delete], {:href => "/confirmation#{link}", :class => 'delete'}
    end
  end

  def add_button(link, value = 'Dodaj +')
    link_to value, link, :class => 'add'
  end

  def render_markdown(text)
    Redcarpet.new(text, :hard_wrap).to_html
  end
end
