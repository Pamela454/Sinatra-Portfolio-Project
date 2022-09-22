source "https://rubygems.org"
ruby "2.6.1"
# Specify your gem's dependencies in emr.gemspec
gem 'sinatra', '~> 2.2', '>= 2.2.1'
gem 'activerecord', '~> 5.0', '>= 5.0.0.1' 
gem 'sinatra-activerecord', :require => 'sinatra/activerecord' 
gem 'rack-flash3'
gem 'rake'
gem 'require_all'
gem 'shotgun', git: 'https://github.com/delonnewman/shotgun.git'
gem 'dm-core'
gem 'thin', '~> 1.7'
gem 'bcrypt', '~> 3.1.2'
gem 'sysrandom'
gem 'dotenv'

group :development do
  gem 'sqlite3'
  gem 'tux'
  gem 'pry'
 end

group :production do
  gem 'pg'
end

group :test do
  gem 'rspec'
  gem 'capybara'
  gem 'rack-test'
  gem 'database_cleaner', git: 'https://github.com/bmabey/database_cleaner.git'

end
