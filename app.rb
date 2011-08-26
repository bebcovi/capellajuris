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
    (('/' + page[:normal]) == request.path_info)
  end
end

get '/delete' do
  Post.order(:id).last.delete
  redirect :index
end

get '/' do
  redirect :index
end

get '/:page' do
  haml params[:page].to_sym
end

get '/post/new' do
  @post = Post.new
  haml :post
end

get '/post/:id' do
  @post = Post[params[:id]]
  haml :post
end

put '/edit/' do
  post = Post[params[:id]] || Post.new
  post.title, post.subtitle = params[:title], params[:subtitle]
  post.body = params[:body]
  post.created_at = Date.today unless post.id
  post.save
  redirect :index
end

delete '/delete/:id' do
  Post[params[:id]].delete
  redirect :index
end

get '/css/style.css' do
  sass :'css/style'
end
