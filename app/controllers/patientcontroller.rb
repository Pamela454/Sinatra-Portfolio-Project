require 'sinatra/base' #is this necessary?
require 'rack-flash'

class PatientController < ApplicationController
  enable :sessions
  use Rack::Flash

  get '/login' do
    if logged_in?
      redirect "/patients"
    else
      erb :"/patients/login"
    end
  end

  post '/login' do
    @patient = Patient.find_by(username: params[:username])
      if @patient && @patient.authenticate(params[:password])
          session[:patient_id] = @patient.id
          redirect '/patients'
      else
          redirect '/login'
      end
    end

    get '/logout' do
      session.clear
      redirect "/login"
    end
end
