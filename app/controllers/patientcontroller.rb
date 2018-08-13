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

    get "/patients/:id" do
    if logged_in?
      @patient = Patient.find_by(id: params[:id])
      erb :"/patients/show"
    else
      redirect "/patients/login"
    end
  end

  get "/patients/:id/edit" do
    @patient = Patient.find_by(id: params[:id])

    if !logged_in?
      redirect "/patients/login"
    elsif current_user.id == @patient.physician_id
      erb :"/patients/edit_patient"
    else
      redirect "/patients/show"
    end
  end

  post "/patients/:id" do
    @patient = Patient.find_by(id: params[:id])

    if params[:content] != ""
      @patient.content = params[:content]
      @patient.save
      redirect "/patients/#{@patient.id}"
    else
      redirect "/patients/#{@patient.id}/edit"
    end
  end

    get '/logout' do
      session.clear
      redirect "/patients/login"
    end
end
