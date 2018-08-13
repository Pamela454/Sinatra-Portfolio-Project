require './config/environment'  #this will need to be updated

if ActiveRecord::Migrator.needs_migration?
  raise 'Migrations are pending. Run `rake db:migrate` to resolve the issue.'
end

use Rack::MethodOverride #middleware that provides put, patch, delete requests
run ApplicationController
use PatientController
use PhysicianController
