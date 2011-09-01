# encoding:utf-8
require 'sinatra'
require_relative 'config'

get '/' do
  haml :index
end

get '/:page' do
  haml params[:page].to_sym
end

post '/login' do
  if auth?
    login
    redirect :index
  else
    @message = 'Krivo korisničko ime ili lozinka.'
    haml :login
  end
end

post '/logout' do
  logout
  redirect :index
end

before '/user' do
  if params[:action] == 'Odustani'
    redirect :index
  end
end

put '/user' do
  if auth?
    User.first.update(:username => params[:new_username], :password => params[:new_password])
    redirect :index
  else
    @message = 'Krivo korisničko ime ili lozinka.'
    haml :user
  end
end

get '/post/new' do
  if logged_in?
    @post = Post.new
    haml :post
  end
end

get '/post/:id' do
  if logged_in?
    @post = Post[params[:id]]
    haml :post
  end
end

before '/edit_post/:id' do
  if params[:action] == 'Odustani'
    redirect :index
  end
end

put '/edit_post/:id' do
  post = Post[params[:id]] || Post.new
  post.title, post.subtitle, post.body = params[:title], params[:subtitle], params[:body]
  post.created_at = Date.today unless post.id
  post.save
  redirect :index
end

delete '/delete_post/:id' do
  Post[params[:id]].delete
  redirect :index
end

get '/css/style.css' do
  sass :'css/style'
end
