# encoding:utf-8
Pages = [
  {normal: 'index', croatian: 'Početna'},
  {normal: 'o_nama', croatian: 'O Nama'},
  {normal: 'slike', croatian: 'Slike'},
  {normal: 'video', croatian: 'Video'}
]

helpers do
  def current?(page)
    ('/' + page[:normal] == request.path_info) or (page[:normal] == 'index' and request.path_info == '/')
  end

  def authenticate!
    if not User[:username => params[:username], :password => params[:password]]
      session[:error] = 'Krivo korisničko ime ili lozinka.'
      redirect back
    end
  end

  def log_in!
    session[:logged] = true
  end

  def log_out!
    session[:logged] = false
  end

  def logged_in?
    session[:logged]
  end

  def voice_to_cro(voice)
    case voice
    when 'S'; 'Soprani'
    when 'A'; 'Alti'
    when 'T'; 'Tenori'
    when 'B'; 'Basi'
    end
  end

  def string_to_id(string)
    string.downcase.delete(' ').gsub(/[ČĆčć]/, 'c').gsub(/[Šš]/, 's').gsub(/[Đđ]/, 'd').gsub(/[Žž]/, 'z')
  end

  def validate_post!
    session[:error] = "Naslov ne smije ostati prazan. " if params[:title] == ""
    session[:error] += "Tijelo ne smije ostati prazno." if params[:body] == ""
    params[:id] = nil if params[:id] == 'new'
    session[:post] = Post.new(:id => params[:id], :title => params[:title], :body => params[:body])
    redirect back if session[:error]
  end

  def validate_content!
    session[:error] = "Naslov ne smije ostati prazan. " if params[:title] == ""
    session[:error] += "Tijelo ne smije ostati prazno." if params[:body] == ""
    params[:id] = nil if params[:id] == 'new'
    session[:content] = Content.new(:id => params[:id], :title => params[:title], :body => params[:body])
    redirect back if session[:error]
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

    def button(attr)
      form_tag(action: attr[:action], method: (attr[:method] || 'get'), style: 'display: inline') do
        haml_tag :input, {type: submit, value: attr[:value]}
      end
    end
  end
end
