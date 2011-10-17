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

Dir['extras/*'].each { |extra| require extra }

# Haml & Sass/Compass
configure do
  Compass.configuration do |config|
    config.sass_dir = 'views/css'
    config.images_dir = 'public/images'
    config.http_images_path = File.join(config.http_path, 'images')
    config.line_comments = false
  end
end

configure :development do
  disable :logging

  class CustomLogger
    def initialize(app)
      @app = app
    end

    def call(env)
      before_call = Time.now
      result = @app.call(env)
      delta = Time.now - before_call
      env['rack.errors'].puts "%s %s %.4fs" % [env['REQUEST_METHOD'], env['PATH_INFO'], delta]
      result
    end
  end

  use CustomLogger
end

# ActiveRecord
set :database, "sqlite://development.db"
require 'db/models'

# Sinatra
enable :sessions

# Sinatra Boilerplate
set :js_assets, %w[js/gollum.editor.js js/markdown.js js/add.coffee js/post.coffee js/init.coffee]


# Javascript
get '/js/add.js' do
  coffee :'js/post'
end

get '/js/post.js' do
  coffee :'js/post'
end

get '/js/init.js' do
  coffee :'js/init'
end


# CSS
get '/css/screen.css' do
  css = Sass::Engine.for_file File.join(settings.views, 'css/screen.sass'), settings.sass.merge(syntax: :sass)
  files = css.dependencies.map {|e| e.options[:filename] }.select { |f| f !~ /compass/ and f =~ /\.s[ca]ss$/ }
  mtime = files.map {|f| File.mtime f }.max
  content_type 'text/css'
  last_modified mtime
  css.to_css
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

before '/:page/:smth' do
  if params[:smth] == 'new' or params[:smth] =~ /^\d+$/
    halt 404 if not logged_in?
  end
end

get '/content/new' do
  session[:referrer] = URI.parse(request.referrer) if request.referrer
  haml :'forms/content', locals: {content: Content.new(page: session[:referrer].path)}
end

post '/content/new' do
  content = Content.create(text: params[:text], content_type: 'content', page: session[:referrer])
  redirect content.page
end

get '/content/:id' do
  haml :'forms/content', locals: {content: Content.find(params[:id])}
end

put '/content/:id' do
  Content.find(params[:id]).update_attributes(text: params[:text])
  redirect Content.find(params[:id]).page
end

delete '/content/:id' do
  if params[:confirmation].nil?
    haml :'forms/confirm'
  else
    content = Content.find(params[:id]).destroy
    redirect content.page
  end
end

[:post, :put].each do |method|
  send(method, '/preview') do
    haml :preview, locals: {text: params[:text]}
  end
end

get '/sidebar/:id' do
  haml :'forms/sidebar', locals: {sidebar: Sidebar.find(params[:id])}
end

put '/sidebar/:id' do
  sidebar = Sidebar.find(params[:id]).update_attributes(
    video_title: params[:video_title], video: params[:video],
    audio_title: params[:audio_title], audio: params[:audio])

  sidebar.valid? ? redirect(:/) : haml(:'forms/sidebar', locals: {sidebar: sidebar})
end

get '/news/new' do
  haml :'forms/content', locals: {content: News.new}
end

post '/news/new' do
  News.create(text: params[:text])
  redirect :/
end

get '/news/:id' do
  haml :'forms/content', locals: {content: News.find(params[:id])}
end

put '/news/:id' do
  News.find(params[:id]).update_attributes(text: params[:text])
  redirect :/
end

delete '/news/:id' do
  if params[:confirmation].nil?
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
  haml :'forms/member', locals: {voice: params[:voice]}
end

post '/member/:voice/new' do
  Member.create(first_name: params[:first_name], last_name: params[:last_name], voice: params[:voice])
  redirect '/members'
end

delete '/member/:id' do
  if params[:confirmation].nil?
    haml :'forms/confirm'
  else
    Member.find(params[:id]).destroy
    haml :'forms/members'
  end
end

put '/content/:id/move' do
  redirect Content.find(params[:id]).move(params[:direction]).page
end

get '/video/new' do
  haml :'forms/video'
end

post '/video/new' do
  Video.create(title: params[:title], url: params[:url])
  redirect :video
end

delete '/video/:id' do
  if params[:confirmation].nil?
    haml :'forms/confirm'
  else
    Video.find(params[:id]).destroy
    redirect :video
  end
end

get '/arhiva' do
  haml :arhiva, locals: {news: News.order('created_at DESC').paginate(:page => params[:page])}
end

get '/:page' do
  halt 404 unless File.exist? File.join(settings.views, params[:page] + '.haml')
  haml params[:page].to_sym
end

not_found do
  haml :'404'
end
