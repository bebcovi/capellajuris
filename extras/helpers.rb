# encoding: UTF-8
helpers do
  def current?(page)
    if request.path_info == '/'
      true if page.haml_name == 'index'
    else
      '/' + page.haml_name == request.path_info
    end
  end

  def current_page
    Page.all.select { |page| current?(page) }.first.try(:haml_name)
  end
  end

  def authenticate(&block)
    if user = User.authenticate(params[:user])
      yield user
    else
      @error = 'Krivo korisničko ime ili lozinka.'
      haml :login
    end
  end

  def register(&block)
    yield User.create(params[:user])
  end

  def log_in(user)
    session[:id] = user.id
  end

  def log_out
    session[:id] = nil
  end

  def logged_in?
    true # session[:id]
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
    content = Hpricot(Redcarpet.new(text || "", :hard_wrap).to_html)
    content.search(:p).each do |paragraph|
      if img = paragraph.at(:img)
        paragraph.swap(img.to_html)
      end
    end
    return content.to_html
  end

  def render_partial(partial, options = {}, locals = {})
    haml :"partials/_#{partial}", options, locals
  end

  def generate_arrows(content)
    form_tag(action: "/content/#{content.id}/move", method: 'put', class: 'order') do
      haml_tag :input, value: '▲', name: 'direction', type: 'submit', class: 'up'
      haml_tag :input, value: '▼', name: 'direction', type: 'submit', class: 'down'
    end
  end

  def previous_page
    session[:referrer] || URI.parse(request.referrer).path
  end
end

class String
  def underscorize
    tr('ČĆŽŠĐčćžšđ', 'CCZSDcczsd').downcase.gsub(/\s/, '_')
  end
end
