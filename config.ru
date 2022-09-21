ENV['SINATRA_ENV'] ||= "development"

require './config/environment' 
require 'pry'
require 'toodeloo'
run Sinatra::Application

if ActiveRecord::Base.connection.migration_context.needs_migration?
  raise 'Migrations are pending. Run `rake db:migrate` to resolve the issue.'
end

use Rack::MethodOverride
use PatientsController
use PhysiciansController
run ApplicationController
