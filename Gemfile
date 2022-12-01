# frozen_string_literal: true

source 'https://rubygems.org'
ruby '2.7.0'
# Specify your gem's dependencies in emr.gemspec
gem 'activerecord', '~> 5.0', '>= 5.0.0.1'
gem 'active_record_fix_integer_limit'
gem 'bcrypt', '~> 3.1.2'
gem 'dm-core'
gem 'dotenv'
gem 'pry'
gem 'rack-flash3'
gem 'rake'
gem 'require_all'
gem 'shotgun', git: 'https://github.com/delonnewman/shotgun.git'
gem 'sinatra', '~> 2.2'
gem 'sinatra-activerecord', require: 'sinatra/activerecord'
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
  gem 'erb-formatter'
end

group :test do
  gem 'capybara'
  gem 'database_cleaner', git: 'https://github.com/bmabey/database_cleaner.git'
  gem 'rack-test'
  gem 'rspec'
end
