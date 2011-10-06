require 'sinatra/activerecord/rake'

task "db:migrate" => :load_app

task :load_app => :fix_damn_loadpath do
  require 'app'
end

task :fix_damn_loadpath do
  $:.unshift File.expand_path('..', __FILE__)
end
