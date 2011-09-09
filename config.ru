Encoding.default_external = 'utf-8'

$:.unshift File.expand_path('..', __FILE__)
require 'app'

if 'shotgun' == File.basename($0)
  require 'ruby-debug'
  Debugger.settings[:autoeval] = true
  Debugger.settings[:autolist] = 1
  Debugger.settings[:reload_source_on_change] = true
  Debugger.start
end

run Sinatra::Application
