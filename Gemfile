source :rubygems

gem 'rake'
gem 'sinatra'
gem 'haml'
gem 'sass'
gem 'compass'
gem 'coffee-script'
gem 'uglifier'
gem 'sequel'
gem 'redcarpet'
gem 'sqlite3'
gem 'i18n'
gem 'activesupport'
gem 'faraday-stack'
gem 'bcrypt-ruby'
gem 'will_paginate', '~> 3.0.2'

gem 'sinatra-activerecord'
gem 'activerecord'

group :development do
  gem 'thin'
  gem 'shotgun'
end

group :development, :test do
  gem 'ruby-debug', :require => nil, :platforms => :mri_18
  gem 'ruby-debug19', :require => nil, :platforms => :mri_19 unless '1.9.3' == RUBY_VERSION
end

group :production do
  gem 'therubyracer-heroku', '~> 0.8.1.pre3'
end
