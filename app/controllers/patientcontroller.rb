require 'sinatra/base' #is this necessary?
require 'rack-flash'

class PatientController < ApplicationController
  enable :sessions
  use Rack::Flash

  get '/patients/login' do
    if logged_in?
      redirect "/patients/show"  #needs to be restful route
    else
      erb :"/patients/login"
    end
  end

  post '/patients/login' do
    @patient = Patient.find_by(username: params[:username])
      if @patient && @patient.authenticate(params[:password])
          session[:patient_id] = @patient.id
          flash[:message] = "Successfull login."
          redirect '/patients/login'  #restful display
      else
          redirect '/patients/login'
      end
    end

    get '/logout' do
      session.clear
      redirect "/patients/login"
    end
end
