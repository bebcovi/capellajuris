configure do
  Compass.configuration do |config|
    config.project_path = File.dirname(__FILE__)
    config.sass_dir = 'views/css'
    config.line_comments = false
  end

  set :haml, { :format => :html5 }
  set :sass, Compass.sass_engine_options
end
