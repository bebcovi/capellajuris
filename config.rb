require 'haml'
require 'sass'
require 'compass'
require 'sequel'

require_relative 'helpers'
require_relative 'extras/cro_dates'

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
DB = Sequel.sqlite 'development.db'
Sequel::Model.plugin(:schema)

# Sinatra
enable :run
enable :sessions

# Database Models
Dir['models/*.rb'].each { |model| require_relative model}
