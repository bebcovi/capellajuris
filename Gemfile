source 'http://rubygems.org'

gem 'thin'
gem 'rails', '3.2.1'
gem 'pg'

# Gems used only for assets and not required
# in production environments by default.
group :assets do
  gem 'sass-rails'
  gem 'coffee-rails'
  gem 'uglifier'
  gem 'compass', '0.12.alpha.4'
end

gem 'jquery-rails'
gem 'haml-rails'
gem 'will_paginate'
gem 'rack-pjax'

group :development do
  gem "linecache19", "0.5.13"
  gem "ruby-debug-base19", "0.11.26"
  gem "ruby-debug19", :require => "ruby-debug"
end

group :test do
  # Pretty printed test output
  gem 'turn', :require => false
  gem 'minitest'
  gem 'aws-s3'
  gem 'ruby-prof'
end

group :production do
  gem 'heroku_backup_task'
end

gem 'redcarpet', '< 2.0.0'
gem 'faraday-stack', :require => false
gem 'nokogiri'

gem 'choices'

gem 'carrierwave', :git => "git://github.com/jnicklas/carrierwave.git"
gem 'fog'
