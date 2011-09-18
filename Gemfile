source :rubygems

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

group :development do
  gem 'thin'
  gem 'shotgun'
end

group :development, :test do
  gem 'ruby-debug', :require => nil, :platforms => :mri_18
  gem 'ruby-debug19', :require => nil, :platforms => :mri_19
end

group :production do
  gem 'therubyracer-heroku', '~> 0.8.1.pre3'
end
