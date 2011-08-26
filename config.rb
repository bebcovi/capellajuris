require 'haml'
require 'sass'
require 'compass'
require 'sequel'

# Haml & Sass/Compass
configure do
  Compass.configuration do |config|
    config.project_path = File.dirname(__FILE__)
    config.sass_dir = 'views/css'
    config.line_comments = false
  end

  set :haml, { :format => :html5 }
  set :sass, Compass.sass_engine_options
end

# Sequel
DB = Sequel.connect 'sqlite://development.db'

# Sinatra
enable :sessions

# Models
require_relative 'models/post.rb'
