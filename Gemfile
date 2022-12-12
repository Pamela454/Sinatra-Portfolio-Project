# frozen_string_literal: true

source 'https://rubygems.org'
ruby '3.1.0'
# Specify your gem's dependencies in emr.gemspec
gem 'activemodel', '~> 7.0', '>= 7.0.4'
gem 'activerecord', '~> 7.0', '>= 7.0.4'
gem 'active_record_fix_integer_limit'
gem 'bcrypt', '~> 3.1.2'
gem 'dm-core'
gem 'dotenv'
gem 'pry'
gem 'rack-flash3'
gem 'rake'
gem 'require_all'
gem 'shotgun', git: 'https://github.com/delonnewman/shotgun.git'
gem 'sinatra', '~> 3.0', '>= 3.0.4'
gem 'sinatra-activerecord', '~> 2.0', '>= 2.0.26', require: 'sinatra/activerecord'
gem 'sysrandom'
gem 'thin', '~> 1.7'
gem 'erb-formatter'

group :development do
  gem 'sqlite3'
  gem 'tux'
  gem 'erb-formatter'
end

group :production do
  gem 'pg'
end

group :test do
  gem 'capybara'
  gem 'database_cleaner', git: 'https://github.com/bmabey/database_cleaner.git'
  gem 'rack-test'
  gem 'rspec'
end
