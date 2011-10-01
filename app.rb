# encoding:utf-8
require 'sinatra'
require 'haml'
require 'sass'
require 'compass'
require 'sequel'
require 'sqlite3'
require 'bluecloth'
require 'active_support/core_ext/string/inflections'
require 'active_support/inflections'
require 'active_support/core_ext/object/blank'
require 'extras/flickr'

require_relative 'helpers'
require_relative 'extras/cro_dates'

# Haml & Sass/Compass
configure do
  Compass.configuration do |config|
    config.project_path = File.dirname(__FILE__)
    config.sass_dir = 'views/css'
    config.images_dir = 'public/images'
    config.line_comments = false
  end

  set :haml, { :format => :html5 }
  set :sass, Compass.sass_engine_options
end

# Sequel
DB = Sequel.sqlite 'databases/master.db'

module Sequel
  extension :pretty_table

  class Model
    plugin :schema
    plugin :validation_helpers
  end
end

# Sinatra
enable :sessions

# Database Models
Dir['models/*.rb'].each { |model| require_relative model}



# Application


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
  halt 404 if not logged_in?
  haml "forms/#{params[:form]}".to_sym
end

post '/login' do
  authenticate! do
    log_in!
    redirect :/
  end
end


get '/intro/' do
  halt 404 if not logged_in?
  @content = Intro.first
  haml :'forms/edit'
end

put '/intro/' do
  redirect :/ if cancel_pressed?
  @content = Intro.first.set(params.reject {|key, value| ['action', '_method'].include? key})
  if @content.valid?
    @content.save
    redirect :/
  else
    haml :'forms/edit'
  end
end


get '/sidebar/:id' do
  halt 404 if not logged_in?
  @sidebar = Sidebar[params[:id]]
  haml :'forms/sidebar'
end

put '/sidebar/:id' do
  @sidebar = Sidebar[params[:id]].set(video_title: params[:video_title], video: params[:video],
                                      audio_title: params[:audio_title], audio: params[:audio])
  if @sidebar.valid?
    @sidebar.save
    redirect :/
  else
    haml :'forms/sidebar'
  end
end

get '/news/new' do
  halt 404 if not logged_in?
  @content = News.new
  haml :'forms/edit'
end

post '/news/new' do
  News.create(params.merge(:created_at => Date.today).reject {|key, value| key == 'action'}) unless cancel_pressed?
  redirect :/
end


get '/news/:id' do
  halt 404 if not logged_in?
  @content = News[params[:id]]
  haml :'forms/edit'
end

put '/news/:id' do
  News[params[:id]].update(params.reject {|key, value| ['action', '_method'].include? key}) unless cancel_pressed?
  redirect :/
end

delete '/news/:id' do
  News[params[:id]].delete
  redirect :/
end


get '/other_content/new' do
  halt 404 if not logged_in?
  session[:page] = back.split('/').last
  @content = OtherContent.new
  haml :'forms/edit'
end

post '/other_content/new' do
  redirect session[:page] if cancel_pressed?
  @content = OtherContent.new(params.reject {|key, value| key == 'action'})
  if @content.valid?
    @content.save
    redirect session[:page]
  else
    haml :'forms/edit'
  end
end


get '/other_content/:id' do
  halt 404 if not logged_in?
  session[:page] = back.split('/').last
  @content = OtherContent[params[:id]]
  haml :'forms/edit'
end

put '/other_content/:id' do
  redirect session[:page] if cancel_pressed?
  @content = OtherContent[params[:id]].set(params.reject {|key, value| ['action', 'id', '_method'].include? key})
  if @content.valid?
    @content.save
    redirect session[:page]
  else
    haml :'forms/edit'
  end
end

delete '/other_content/:id' do
  OtherContent[params[:id]].destroy
  redirect back
end


post '/member/new' do
  @member = Member.new(params)
  if @member.valid?
    @member.save
    redirect :'forms/members'
  else
    haml :'forms/members'
  end
end

delete '/member/:id' do
  Member[params[:id]].delete
  redirect :'forms/members'
end


get '/activity_year/new' do
  halt 404 if not logged_in?
  @content = ActivityYear.new(:title => ActivityYear.max(:title) + 1)
  haml :'forms/edit'
end

post '/activity_year/new' do
  redirect Content[:type => 'activities'].page if cancel_pressed?
  @content = ActivityYear.new(params.reject {|key, value| key == 'action'})
  if @content.valid?
    @content.save
    redirect Content[:type => 'activities'].page
  else
    haml :'forms/edit'
  end
end


get '/activity_year/:id' do
  halt 404 if not logged_in?
  session[:page] = back.split('/').last
  @content = ActivityYear[params[:id]]
  haml :'forms/edit'
end

put '/activity_year/:id' do
  redirect session[:page] if cancel_pressed?
  @content = ActivityYear[params[:id]].set(params.reject {|key, value| ['action', 'id', '_method']})
  if @content.valid?
    @content.save
    redirect session[:page]
  else
    haml :'forms/edit'
  end
end

delete '/activity_year/:id' do
  ActivityYear[params[:id]].delete
  redirect back
end


get '/css/screen.css' do
  sass :'css/screen'
end


not_found do
  "A 'Not found' message here."
end
