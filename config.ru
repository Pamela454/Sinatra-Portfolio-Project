#execution point of any rack application
require './config/environment'  #this will need to be updated
require 'pry'

if ActiveRecord::Base.connection.migration_context.needs_migration?
  raise 'Migrations are pending. Run `rake db:migrate` to resolve the issue.'
end
#must explicitly mount controllers. can only run one controller.
use Rack::MethodOverride #middleware that provides put, patch, and delete requests
use PatientsController
use PhysiciansController
run ApplicationController
