Encoding.default_external = 'utf-8'

$:.unshift File.expand_path('..', __FILE__)
require 'app'

process = File.basename($0)

if 'shotgun' == process or 'rackup' == process
  begin
    require 'ruby-debug'
  rescue LoadError
    $stderr.puts "Warning: ruby-debug not available"
  else
    Debugger.settings[:autoeval] = true
    Debugger.settings[:autolist] = 1
    Debugger.settings[:reload_source_on_change] = true
    Debugger.start
  end
end

ENV['TMPDIR'] = "/tmp" unless ENV['TMPDIR']

run Sinatra::Application
