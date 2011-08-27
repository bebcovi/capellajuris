# encoding:utf-8
require 'sinatra'
require_relative 'config'

require_relative 'extras/cro_dates'

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

put '/user' do
  if params[:action] == 'Odustani'
    redirect :index
  else
    if auth?
      User.first.update(:username => params[:new_username], :password => params[:new_password])
      redirect :index
    else
      @message = 'Krivo korisničko ime ili lozinka.'
      haml :user
    end
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

put '/edit' do
  if params[:action] == 'Odustani'
    redirect :index
  else
    post = Post[params[:id]] || Post.new
    post.title, post.subtitle, post.body = params[:title], params[:subtitle], params[:body]
    post.created_at = Date.today unless post.id
    post.save
    redirect :index
  end
end

delete '/delete' do
  Post[params[:id]].delete
  redirect :index
end

get '/css/style.css' do
  sass :'css/style'
end
