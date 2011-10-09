# encoding:utf-8
require 'sinatra'
require 'sequel'
require 'sinatra/activerecord'
require 'sqlite3'
require 'redcarpet'
require 'active_support/core_ext/string/inflections'
require 'active_support/inflections'
require 'active_support/core_ext/object/blank'
require 'uri'
require 'bcrypt'
require 'will_paginate'
require 'will_paginate/active_record'
require 'hpricot'

require 'sinatra_boilerplate'
require 'helpers'
require 'extras/cro_dates'
require 'extras/flickr'

# Haml & Sass/Compass
configure do
  Compass.configuration do |config|
    config.sass_dir = 'views/css'
    config.images_dir = 'public/images'
    config.http_images_path = File.join(config.http_path, 'images')
    config.line_comments = false
  end
end

# ActiveRecord
set :database, "sqlite://development.db"

# Models
Dir['db/models/*'].each { |model| require_relative model }

# Sinatra
enable :sessions

# Sinatra Boilerplate
set :js_assets, %w[js/post.coffee, js/init.coffee, js/gollum.editor.js, js/markdown.js]


# Javascript
get '/js/init.js' do
  coffee :'js/init'
end

get '/js/post.js' do
  coffee :'js/post'
end

# CSS
get '/css/screen.css' do
  sass :'css/screen'
end


get '/' do
  haml :index
end


post '/login' do
  send(User.exists? ? "authenticate" : "register") do |user|
    log_in(user)
    redirect :/
  end
end

get '/logout' do
  log_out
  redirect :/
end


before ':page/:smth' do
  if params[:smth] == 'new' or params[:smth] =~ /^\d+$/
    halt 404 if not logged_in?
  end
end


get '/content/new' do
  referrer = URI.parse(request.referrer) if request.referrer
  @content = Content.new(page: referrer.path)
  haml :'forms/content'
end

[:post, :put].each do |method|
  send(method, '/preview') do
    @text = params[:text]
    haml :preview
  end
end

post '/content/new' do
  Content.create(text: params[:text], content_type: 'content', page: params[:page])
  redirect params[:page]
end

get '/content/:id' do
  @content = Content.find(params[:id])
  haml :'forms/content'
end

put '/content/:id' do
  Content.find(params[:id]).update_attributes(text: params[:text])
  redirect params[:page]
end

delete '/content/:id' do
  if params[:confirmation].blank?
    haml :'forms/confirm'
  else
    content = Content.find(params[:id]).destroy
    redirect content.page
  end
end

get '/sidebar/:id' do
  @sidebar = Sidebar.find(params[:id])
  haml :'forms/sidebar'
end

put '/sidebar/:id' do
  @sidebar = Sidebar.find(params[:id]).update_attributes(
    video_title: params[:video_title], video: params[:video],
    audio_title: params[:audio_title], audio: params[:audio])

  @sidebar.valid? ? redirect(:/) : haml(:'forms/sidebar')
end

get '/news/new' do
  @content = News.new
  haml :'forms/content'
end

post '/news/new' do
  News.create(text: params[:text])
  redirect :/
end

get '/news/:id' do
  @content = News.find(params[:id])
  haml :'forms/content'
end

put '/news/:id' do
  News.find(params[:id]).update_attributes(text: params[:text])
  redirect :/
end

delete '/news/:id' do
  if params[:confirmation].blank?
    haml :'forms/confirm'
  else
    News.find(params[:id]).destroy
    redirect :/
  end
end

get '/members' do
  halt 404 if not logged_in?
  haml :'forms/members'
end

get '/member/:voice/new' do
  halt 404 if not logged_in?
  @voice = params[:voice]
  haml :'forms/member'
end

post '/member/:voice/new' do
  Member.create(first_name: params[:first_name], last_name: params[:last_name], voice: params[:voice])
  redirect '/members'
end

delete '/member/:id' do
  if params[:confirmation].blank?
    haml :'forms/confirm'
  else
    Member.find(params[:id]).destroy
    haml :'forms/members'
  end
end


put '/content/:id/move' do
  content = Content.find(params[:id]).move(params[:direction])
  redirect content.page
end


get '/arhiva' do
  @news = News.order('created_at DESC').paginate(:page => params[:page])
  haml :arhiva
end

get '/:page' do
  haml params[:page].to_sym
end


not_found do
  haml :'404'
end
