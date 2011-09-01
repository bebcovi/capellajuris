# encoding:utf-8
helpers do
  def page_on_croatian(page)
    case page
    when 'index'; 'Početna'
    when 'o_nama'; 'O Nama'
    when 'slike'; 'Slike'
    when 'video'; 'Video'
    end
  end

  def current?(page)
    ('/' + page == request.path_info) or (page == 'index' and request.path_info == '/')
  end

  def authenticate!
    if not User[:username => params[:username], :password => params[:password]]
      session[:error] = 'Krivo korisničko ime ili lozinka.'
      redirect back
    end
  end

  def log_in!
    session[:logged] = true
    session[:error] = nil
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
    if params[:title].empty? or params[:body].empty?
      redirect :index if params[:title].empty? and params[:body].empty?
      session[:error] = "Rubrika za naslov ili tijelo je ostala prazna."
    end
    session[:post] = Post[params[:id]] || Post.new
    session[:post].title, session[:post].body = params[:title], params[:body]
    redirect back if session[:error]
  end

  def validate_content!
    if params[:title].empty? or params[:body].empty?
      redirect :index if params[:title].empty? and params[:body].empty?
      session[:error] = "Rubrika za naslov ili tijelo je ostala prazna."
    end
    session[:content] = Content[params[:id]] || Content.new
    session[:content].title, session[:content].body = params[:title], params[:body]
    redirect back if session[:error]
  end
end

module Haml
  module Helpers
    def form_tag(attr, &block)
      if attr[:method] == 'get' or attr[:method] == 'post'
        haml_tag(:form,     { action: attr[:action],
                              method: attr[:method],
                              id: attr[:id]}) { yield }
      else
        haml_tag(:form,     { action: attr[:action],
                              method: 'post',
                              id: attr[:id]}) do

          haml_tag(:input,  { type: 'hidden',
                              name: '_method',
                              value: attr[:method]}) do
            yield
          end
        end
      end
    end

    def button(attr)
      form_tag(action: attr[:action], method: (attr[:method] || 'get'), style: 'display: inline', id: attr[:id]) do
        haml_tag :input, {type: 'submit', value: attr[:value]}
      end
    end
  end
end
