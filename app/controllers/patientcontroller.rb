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
          session[:id] = @patient.id  #set session id equal to user id after saving user
          flash[:message] = "Successfull login."
          redirect '/patients/:id'  #restful display, take to patient's page
      else
          redirect '/patients/login'
      end
    end

    get '/logout' do
      session.clear
      redirect "/patients/login"
    end
end
