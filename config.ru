#execution point of any rack application
require './config/environment'  #this will need to be updated

if ActiveRecord::Migrator.needs_migration?
  raise 'Migrations are pending. Run `rake db:migrate` to resolve the issue.'
end
#must explicitly mount controllers. can only run one controller.
use Rack::MethodOverride #middleware that provides put, patch, and delete requests
use PatientController
use PhysicianController
run ApplicationController
