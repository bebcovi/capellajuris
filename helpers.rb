# encoding: UTF-8
helpers do
  def current?(page)
    '/' + page.url_name == request.path_info
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

  def link_to(text, href, attributes = {})
    haml_tag :a, text, {href: href}.update(attributes)
  end

  def form_tag(form_attr, &block)
    if ['get', 'post'].include? form_attr[:method]
      haml_tag(:form, form_attr, &block)
    else
      haml_tag(:form, form_attr.merge(method: 'post')) do
        haml_tag(:input, {type: 'hidden', name: '_method', value: form_attr[:method]}, &block)
      end
    end
  end

  def buttons(buttons, link)
    haml_tag 'ol.controls' do
      haml_tag :li do
        link_to buttons[:edit], link, class: 'edit'
      end if buttons[:edit].present?
      haml_tag :li do
        form_tag(action: link, method: 'delete', class: 'delete') do
          haml_tag :input, type: 'submit', value: buttons[:delete]
        end
      end if buttons[:delete].present?
    end if buttons[:edit].present? or buttons[:delete].present?

    haml_tag 'div.add' do
      link_to buttons[:add], link
    end if buttons[:add].present?
  end

  def render_markdown(text)
    content = Hpricot(Redcarpet.new(text, :hard_wrap).to_html)
    content.search(:p).each do |paragraph|
      if img = paragraph.at(:img)
        paragraph.set_attribute :class, 'img'
        paragraph.inner_html = img.to_html
      end
    end
    return content.to_html
  end

  def generate_arrows(content)
    form_tag(action: "/content/#{content.id}/move", method: 'put') do
      haml_tag :input, value: '▲', name: 'direction', type: 'submit'
      haml_tag :input, value: '▼', name: 'direction', type: 'submit'
    end
  end
end


module Encryption
  def self.encrypt(password, password_salt)
    BCrypt::Engine.hash_secret(password, password_salt)
  end
end
