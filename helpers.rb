helpers do
  def current?(page)
    ('/' + page[:normal] == request.path_info) or (page[:normal] == 'index' and request.path_info == '/')
  end

  def auth?
    User[:username => params[:username], :password => params[:password]]
  end

  def login
    session[:logged] = true
  end

  def logout
    session[:logged] = false
  end

  def logged_in?
    session[:logged]
  end
end

module Haml
  module Helpers
    def form_tag(attr, &block)
      if attr[:method] == 'get' or attr[:method] == 'post'
        haml_tag(:form, {action: "#{attr[:action]}",
                         method: "#{attr[:method]}",
                         style: "#{attr[:style]}"}) do
          yield
        end
      else
        haml_tag(:form, {action: "#{attr[:action]}",
                         method: 'post',
                         style: "#{attr[:style]}"}) do
          haml_tag(:input, {type: 'hidden',
                            name: '_method',
                            value: "#{attr[:method]}"}) do
            yield
          end
        end
      end
    end
  end
end
