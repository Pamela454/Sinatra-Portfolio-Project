# frozen_string_literal: true

ENV['SINATRA_ENV'] ||= 'development'

require './config/environment'
require 'pry'

use Rack::MethodOverride
use PatientsController
use PhysiciansController
run ApplicationController
