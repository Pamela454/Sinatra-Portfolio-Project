require 'dotenv'
require 'bundler/setup'
Bundler.require(:default, ENV['SINATRA_ENV'])
Dotenv.load

configure :development do
  set :database_file, "./database.yml"
end

ActiveRecord::Base.establish_connection(
  :adapter => "sqlite3",
  :database => "db/#{ENV['SINATRA_ENV']}.sqlite"
)

require_all 'app'
