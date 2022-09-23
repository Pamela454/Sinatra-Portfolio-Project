require 'bundler/setup'
Bundler.require
 
  configure :development do
  ENV['SINATRA_ENV'] ||= "development"
 
  require 'bundler/setup'
  Bundler.require(:default, ENV['SINATRA_ENV'])
 
  set :database_file, "./database.yml"

require_all 'app'