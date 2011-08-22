#encoding:utf-8

# Gems
require 'sinatra'
require 'haml'
require 'sass'
require 'compass'
require 'mysql2'

# User-defined
require_relative 'configs/config'
require_relative 'configs/mysql2'
require_relative 'configs/cro_dates'

enable :sessions

$db = Mysql2::Client.new(host: 'localhost', username: 'root')
$db.query_options.merge!(:symbolize_keys => true)
$db.query('use capellajuris')

helpers do
  def current?(page)
    (('/' + page[:normal]) == request.path_info)
  end
  def posts
    $db.query("SELECT * FROM posts")
  end
  def update_post(title, subtitle, text)
    title, subtitle, text = $db.escape(title), $db.escape(subtitle), $db.escape(text)
    $db.query("UPDATE posts SET title='#{title}', subtitle='#{subtitle}', date=CURDATE(), text='#{text}'")
  end
end

get '/' do
  redirect '/index'
end

get %r{/(arhiva|index|o_nama|slike|video)} do
  session[:pages] = [
    {normal: 'index', croatian: 'Početna'},
    {normal: 'o_nama', croatian: 'O Nama'},
    {normal: 'slike', croatian: 'Slike'},
    {normal: 'video', croatian: 'Video'}
  ]
  haml params[:captures].first.to_sym
end

get '/edit/*' do
  if params[:splat].first.respond_to?(:to_i)
    session[:flag] = params[:splat].first
  end
  redirect :index
end

post '/edit_post' do
  update_post(params[:title], params[:subtitle], params[:text])
end

get '/cancel' do
  session[:flag] = nil
  redirect :index
end

get '/css/style.css' do
  sass :'css/style'
end
