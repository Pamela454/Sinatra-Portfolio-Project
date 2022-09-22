ENV['SINATRA_ENV'] ||= "development"

require './config/environment.rb' 
require 'pry'

use Rack::MethodOverride
use PatientsController
use PhysiciansController
run ApplicationController
