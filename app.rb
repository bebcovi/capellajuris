# encoding:utf-8
require 'sinatra'
require 'sinatra/activerecord'
require 'haml'
require 'sass'
require 'compass'

require_relative 'configs/config'
require_relative 'configs/cro_dates'

class Post < ActiveRecord::Base
end

helpers do
  def current?(page)
    (('/' + page[:normal]) == request.path_info)
  end

  Pages = [
    {normal: 'index', croatian: 'Početna'},
    {normal: 'o_nama', croatian: 'O Nama'},
    {normal: 'slike', croatian: 'Slike'},
    {normal: 'video', croatian: 'Video'}
  ]
end

get '/' do
  redirect :index
end

get '/:page' do
  haml params[:page].to_sym
end

get '/edit/:id' do
  @post = Post.find(params[:id].to_i)
  haml :izmjeni
end

put '/:id' do
  @post = Post.find(params[:id].to_i)
  @post.title, @post.subtitle, @post.body = params[:title], params[:subtitle], params[:body]
  @post.save
  redirect :index
end

get '/index/:id' do
  @post_id = params[:id].to_i
  haml :index
end

delete '/:id' do
  Post.delete(params[:id].to_i)
  redirect :index
end

get '/css/style.css' do
  sass :'css/style'
end
