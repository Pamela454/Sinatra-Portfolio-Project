#require 'dotenv'
require 'bundler/setup'
require 'dotenv'
Dotenv.load

configure :development do
  set :database_file, './database.yml'
end

configure :production do
  db = URI.parse(ENV['postgres://kkppklmjzefocx:8a1c6beba56e7e1c'] || 'postgres://localhost/mydb')

  ActiveRecord::Base.establish_connection(
    :adapter  => db.scheme == 'postgres' ? 'postgresql' : db.scheme,
    :host     => db.host,
    :username => db.user,
    :password => db.password,
    :database => db.path[1..-1],
    :encoding => 'utf8'
  )
end

require_all 'app'
