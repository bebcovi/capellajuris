Encoding.default_external = 'utf-8'

$:.unshift File.expand_path('..', __FILE__)
require 'app'

run Sinatra::Application
