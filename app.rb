# encoding:utf-8
require 'sinatra'
require_relative 'config'

get '/' do
  haml :index
end

get '/:page' do
  pass if form?(params[:page])
  haml params[:page].to_sym
end

get '/:form' do
  haml "forms/#{params[:form]}".to_sym
end

post '/login' do
  authenticate! do
    log_in!
    redirect :/
  end
end

get '/logout' do
  log_out!
  redirect back
end

put '/user' do
  redirect :/ if params[:action] == 'Odustani'
  authenticate! do
    User.first.update(:username => params[:new_username], :password => params[:new_password])
    redirect :/
  end
end


get '/post/new' do
  if logged_in?
    @post = Post.new
    haml :'forms/post'
  end
end

post '/post/new' do
  redirect :/ if params[:action] == 'Odustani'
  validate! do
    Post.create(:title => params[:title], :body => params[:body], :created_at => Date.today)
    redirect :/
  end
end


get '/post/:id' do
  if logged_in?
    @post = Post[params[:id]]
    haml :'forms/post'
  end
end

put '/post/:id' do
  redirect :/ if params[:action] == 'Odustani'
  validate! do
    Post[params[:id]].update(:title => params[:title], :body => params[:body])
    redirect :/
  end
end

delete '/post/:id' do
  Post[params[:id]].delete
  redirect :/
end


get '/content/new' do
  if logged_in?
    @content = Content.new
    haml :'forms/content'
  end
end

post '/content/new' do
  redirect :o_nama if params[:action] == 'Odustani'
  validate! do
    Content.create(:title => params[:title], :body => params[:body])
    redirect :o_nama
  end
end


get '/content/:id' do
  if logged_in?
    @content = Content[params[:id]]
    haml :'forms/content'
  end
end

put '/content/:id' do
  if params[:action] == 'Odustani'
    params[:id] == '1' ? redirect(:/) : redirect(:o_nama)
  end
  validate! do
    Content[params[:id]].update(:title => params[:title], :body => params[:body])
    params[:id] == '1' ? redirect(:/) : redirect(:o_nama)
  end
end

delete '/content/:id' do
  Content[params[:id]].delete unless params[:id] == '1'
  redirect :o_nama
end


get '/css/screen.css' do
  sass :'css/screen'
end
