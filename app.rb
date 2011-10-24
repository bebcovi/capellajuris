# encoding: UTF-8
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
set :js_assets, %w[js/gollum.editor.js js/markdown.js js/patch.js js/ajax.coffee js/post.coffee js/member.coffee js/init.coffee]

# Javascript
get '/js/ajax.js' do
  coffee :'js/ajax'
end

get '/js/add.js' do
  coffee :'js/add'
end

get '/js/post.js' do
  coffee :'js/post'
end

get '/js/member.js' do
  coffee :'js/member'
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
  session[:referrer] ||= URI.parse(request.referrer).path if request.referrer
  @content = Content.new(page: session[:referrer])
  haml :'forms/content'
end

post '/content/new' do
  content = Content.create(params[:content].update(content_type: 'content', page: session[:referrer]))
  redirect content.page
end

get '/content/:id' do
  @content = Content.find(params[:id])
  haml :'forms/content'
end

put '/content/:id' do
  content = Content.update(params[:id], params[:content])
  redirect content.page
end

delete '/content/:id' do
  if params[:confirmation].nil?
    haml :'forms/confirm'
  else
    content = Content.destroy(params[:id])
    redirect content.page
  end
end

[:post, :put].each do |method|
  send(method, '/preview') do
    haml :preview, locals: {text: params[:text]}
  end
end

get '/sidebar/:id' do
  @sidebar = Sidebar.find(params[:id])
  haml :'forms/sidebar'
end

put '/sidebar/:id' do
  @sidebar = Sidebar.update(params[:id], params[:sidebar])
  @sidebar.valid? ? redirect(:/) : haml(:'forms/sidebar')
end

post '/sidebar/:id' do
  if params[:audio].present?
    upload_an_audio_file(params[:audio])
    convert_mp3_to_ogg(params[:audio])
    @message = 'Audio snimka je uspješno učitana.'
  end
  @sidebar = Sidebar.find(params[:id])
  haml :'forms/sidebar'
end

get '/news/new' do
  @content = News.new
  haml :'forms/content'
end

post '/news/new' do
  News.create(params[:content])
  redirect :/
end

get '/news/:id' do
  @content = News.find(params[:id])
  haml :'forms/content'
end

put '/news/:id' do
  News.update(params[:id], params[:content])
  redirect :/
end

delete '/news/:id' do
  if params[:confirmation].nil?
    haml :'forms/confirm'
  else
    News.destroy(params[:id])
    redirect :/
  end
end

get '/members' do
  halt 404 if not logged_in?
  haml :'forms/members'
end

get '/member/:voice/new' do
  halt 404 if not logged_in?
  haml :'forms/member'
end

post '/member/:voice/new' do
  Member.create(first_name: params[:first_name],
                last_name: params[:last_name],
                voice: params[:voice].capitalize)
  redirect :members
end

delete '/member/:id' do
  if params[:confirmation].nil?
    haml :'forms/confirm'
  else
    Member.destroy(params[:id])
    haml :'forms/members'
  end
end

put '/content/:id/move' do
  content = Content.find(params[:id]).move(params[:direction])
  redirect content.page
end

get '/video/new' do
  @video = Video.new
  haml :'forms/video'
end

post '/video/new' do
  Video.create(title: params[:title], url: params[:url])
  redirect :video
end

get '/video/:id' do
  @video = Video.find(params[:id])
  haml :'forms/video'
end

put '/video/:id' do
  Video.update(params[:id], title: params[:title], url: params[:url])
  redirect :video
end

delete '/video/:id' do
  if params[:confirmation].nil?
    haml :'forms/confirm'
  else
    Video.destroy(params[:id])
    redirect :video
  end
end

get '/page/new' do
  session[:referrer] ||= URI.parse(request.referrer).path if request.referrer
  @page = Page.new
  haml :'forms/page'
end

post '/page/new' do
  @page = Page.create(cro_name: params[:cro_name])
  if @page.valid?
    create_new_haml_file(params[:cro_name])
    redirect :"#{@page.haml_name}"
  else
    haml :'forms/page'
  end
end

delete '/page/:id' do
  if params[:confirmation].nil?
    haml :'forms/confirm'
  else
    page = Page.destroy(params[:id])
    File.delete(File.join(settings.views, page.haml_name + '.haml'))
    redirect :/
  end
end

get '/arhiva' do
  @news = News.order('created_at DESC').paginate(:page => params[:page])
  haml :arhiva
end

get '/:page' do
  halt 404 unless File.exist? File.join(settings.views, params[:page] + '.haml')
  session[:referrer] = nil
  haml params[:page].to_sym
end

not_found do
  haml :'404'
end
