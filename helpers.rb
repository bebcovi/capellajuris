# encoding:utf-8
helpers do
  def current?(page)
    '/' + page.haml_name == request.path_info
  end

  def form?(page)
    Dir['views/forms/*'].include? "views/forms/#{page}.haml"
  end

  def authenticate!(&block)
    if not User[:username => params[:username], :password => params[:password]]
      @error = 'Krivo korisničko ime ili lozinka.'
      haml "forms#{request.path_info}".to_sym
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
      haml_tag :a, value, {:href => link, :class => 'edit'}
    end
  end

  def delete_button(link, value = 'Izbriši')
    haml_tag 'div.controls' do
      # haml_tag :a, value, {:href => "/confirmation#{link}", :class => 'delete'}
      form_tag(action: link, method: 'delete') do
        haml_tag :input, {type: 'submit', :class => 'delete', value: value}
      end
    end
  end

  def edit_delete_buttons(link, values = {:edit => 'Izmjeni', :delete => 'Izbriši'})
    haml_tag 'div.controls' do
      haml_tag :a, values[:edit], {:href => link, :class => 'edit'}
      # haml_tag :a, values[:delete], {:href => "/confirmation#{link}", :class => 'delete'}
      form_tag(action: link, method: 'delete') do
        haml_tag :input, {type: 'submit', :class => 'delete', value: values[:delete]}
      end
    end
  end

  def add_button(link, value = 'Dodaj +')
    haml_tag :a, value, {:href => link, :class => 'add'}
  end

  def render_markdown(text)
    Redcarpet.new(text, :hard_wrap).to_html
  end
end

def flickr_sizes
  Flickr::Photo::SIZE_NAMES.keys
end

def string_to_method(string)
  string.downcase.delete(' ')
end

def flickr_method(method, flickr_error = 'Greška dohvaćanja Flickr slike: ',
                          timeout_error = 'Veza sa Flickrom je trenutno spora. Pokušaj ponovno.')
  begin
    Flickr.send(method)
  rescue Flickr::Error => e
    flickr_error + e.message + '.'
  rescue Timeout::Error
    timeout_error
  end
end
