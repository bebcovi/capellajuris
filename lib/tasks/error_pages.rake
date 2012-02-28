require 'nokogiri'
require 'open-uri'

namespace :error_pages do
  task :generate do
    begin
      [401, 404, 500].each do |status_code|
        html = Nokogiri::HTML(open("http://localhost:3000/errors/#{status_code}"))
        File.open("public/#{status_code}.html", "w") { |f| f.write html }
      end
    rescue Errno::ECONNREFUSED
      puts "Rails server probably isn't running."
    end
  end
end
