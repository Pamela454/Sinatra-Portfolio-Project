ENV['SINATRA_ENV'] ||= "development"
ENV['SESSION_SECRET'] ||= "44b3f19a25628c5f2134b3cec3e758f3d0db4caaaa9a7c5af9fa1edf49ff1e3e7c84157aaa090c6e49ed36d3a10925fbab418fbc2dedf3518895835519840af0" 

require 'bundler/setup'
Bundler.require(:default, ENV['SINATRA_ENV'])

configure :development do
  set :database, 'sqlite3:db/database.db'
end

ActiveRecord::Base.establish_connection(
  :adapter => "sqlite3",
  :database => "db/#{ENV['SINATRA_ENV']}.sqlite"
)

require_all 'app'
