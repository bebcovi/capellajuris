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
    if page[:normal] == 'index' and request.path_info == '/'
      true
    else
      ('/' + page[:normal]) == request.path_info
    end
  end

  def auth
    auth_result = Hash.new
    auth_result[:suceeded] = User[:username => params[:username], :password => params[:password]]
    unless auth_result[:suceeded]
      if User[:username => params[:username]]
        auth_result[:message] = 'Kriva lozinka.'
      else
        auth_result[:message] = 'Krivo korisničko ime.'
      end
    end
    return auth_result
  end

  def login(log = true)
    session[:logged] = log
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
  if auth[:suceeded]
    login
    redirect :index
  else
    @message = auth[:message]
    @username = params[:username] if @message == 'Kriva lozinka.'
    haml :login
  end
end

post '/logout' do
  login(false)
  redirect :index
end

put '/user' do
  if params[:action] == 'Odustani'
    redirect :index
  else
    if auth[:suceeded]
      auth[:suceeded].update(:username => params[:new_username], :password => params[:new_password])
      redirect :index
    else
      @message = auth[:message]
      @username = params[:username] if @message == 'Kriva lozinka.'
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

put '/edit/:id' do
  if logged_in?
    post = Post[params[:id]] || Post.new
    post.title, post.subtitle = params[:title], params[:subtitle]
    post.body = params[:body]
    post.created_at = Date.today unless post.id
    post.save
    redirect :index
  end
end

delete '/delete/:id' do
  if logged_in?
    Post[params[:id]].delete
    redirect :index
  end
end

get '/css/style.css' do
  sass :'css/style'
end
