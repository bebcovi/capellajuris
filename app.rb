# encoding:utf-8
require 'sinatra'
require_relative 'config'

get '/' do
  haml :index
end

get '/logout' do
  log_out!
  redirect :/
end

get '/:page' do
  pass if form?(params[:page])
  haml params[:page].to_sym
end

get '/:form' do
  haml "forms/#{params[:form]}".to_sym unless not logged_in? and params[:form] != 'login'
end

post '/login' do
  authenticate! do
    log_in!
    redirect :/
  end
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
    Order.insert(:title => params[:title], :order => Order.max(:order) + 1)
    redirect ("/o_nama##{string_to_id Content[:body => params[:body]].title}".to_sym)
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
    params[:id] == '1' ? redirect(:/) : redirect("/o_nama##{string_to_id Content[params[:id]].title}".to_sym)
  end
  validate! do
    Content[params[:id]].update(:title => params[:title], :body => params[:body])
    params[:id] == '1' ? redirect(:/) : redirect("/o_nama##{string_to_id Content[params[:id]].title}".to_sym)
  end
end

delete '/content/:id' do
  unless params[:id] == '1'
    Order[:title => Content[params[:id]].title].delete
    Content[params[:id]].delete
  end
  redirect :o_nama
end


put '/member/new' do
  session[:members_to_create] << Member.create(:first_name => params[:first_name],
                                               :last_name => params[:last_name],
                                               :voice => params[:voice]).values[:id]
  redirect :members
end

put '/member/:id' do
  session[:members_to_delete] << params[:id].to_i
  redirect :members
end

put '/members' do
  if params[:action] == 'Odustani'
    Member.filter(:id => session[:members_to_create]).delete
  else
    Member.filter(:id => session[:members_to_delete]).delete
  end
  session[:members_to_create] = session[:members_to_delete] = nil
  redirect :'o_nama#clanovizbora'
end


get '/activity/new' do
  if logged_in?
    @activity = Activity.new
    @activity.year = Activity.order(:year).last.year + 1
    haml :'forms/activity'
  end
end

post '/activity/new' do
  Activity.create(:year => params[:year], :thing => params[:things]) if params[:action] != 'Odustani'
  redirect :'o_nama#aktivnosti'
end


get '/activity/:id' do
  if logged_in?
    @activity = Activity[params[:id]]
    haml :'forms/activity'
  end
end

put '/activity/:id' do
  Activity[params[:id]].update(:year => params[:year],
                               :things => params[:things]) if params[:action] != 'Odustani'
  redirect :'o_nama#aktivnosti'
end


get '/css/screen.css' do
  sass :'css/screen'
end
