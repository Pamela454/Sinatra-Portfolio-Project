require 'sinatra/base'
require 'rack-flash'

class PatientsController < ApplicationController
  use Rack::Flash

  get '/patients/login' do
    if self.current_user.class == Patient
      @patient = Patient.find_by(id: session[:id])
      session[:id] = @patient.id
      erb :"/patients/show"
    else
      erb :"/patients/login"
    end
  end

  post '/patients/login' do
    @patient = Patient.find_by(username: params[:username])
    current_user
    if @patient && @patient.authenticate(params[:password]) 
      session[:username] = params[:username]
      session[:id] = @patient.id
      session[:user_type] = "patient"
      redirect "/patients/#{@patient.id}"
    else
      flash[:message] = "Could not authenticate login."
      redirect '/patients/login'
    end
  end

  get '/patients/new' do 
    if self.current_user.class.name == "Physician"
      erb :"/patients/new"
    else
      flash[:message] = "You do not have access to that feature."
      redirect '/'
    end
  end

  post '/patients/new' do
    if params[:username] == nil && params[:password] == nil
      flash[:message] = "Please enter both username and password to create a new patient."
      redirect "/patients/new"
    else
      params[:username] && params[:password] != nil
      @patient = Patient.create(username: params[:username], password: params[:password], physician_id: session[:id],
      medical_history: params[:medical_history], active_problems: params[:active_problems])
      if @patient.save
        @physician = Physician.find_by(id: session[:id])
        @patients = @physician.patients
        flash[:message] = "Successfully added new patient."
        erb :"/physicians/show"
      else
        flash[:message] = "Not valid profile data."
        redirect "/patients/new"
      end
    end
  end

  get '/patients/:id' do  
    if session[:user_type] == "patient" && session[:id] == params[:id].to_i
      @patient = Patient.find_by(id: session[:id])
      flash[:message] = "Successful login."
      erb :"/patients/show"
    else
      flash[:message] = "You do not have access to that feature."
      erb :"/patients/login"
    end
  end

  get '/patients/:id/edit' do 
    if self.current_user.class == Physician
      @patient = Patient.find_by(params[:id])
      erb :"/patients/edit"
    else
      flash[:message] = "You do not have access to that feature."
      redirect '/patients/login'
    end
  end

  patch "/patients/:id" do
    @patient = Patient.find_by(username: params[:username])
    @physician = Physician.find_by(id: session[:id])
    if params[:medical_history] != ""
      @patient.update_attribute(:medical_history, params[:medical_history])
    end
    if params[:active_problems] != ""
      @patient.update_attribute(:active_problems, params[:active_problems])
    end
    flash[:message] = "Successfully edited patient profile."
    redirect "/physicians/#{@physician.id}"
  end

  delete "/patients/:id/delete" do
    current_user
    if @current_user == nil
      flash[:message] = "You do not have access to that feature."
      redirect "/"
    elsif self.current_user.class == Patient
      Patient.find_by(username: session[:username])
      flash[:message] = "You are not permitted to delete this patient."
      redirect "/physicians/#{@physician.id}"
    elsif self.current_user.class == Physician
      @physician = Physician.find_by(username: session[:username])
      @patient = Patient.find_by(id: params[:id])
      @patient.delete
      redirect "/physicians/#{@physician.id}"
    end
  end

  get '/logout' do
    session.clear
    redirect "/"
  end
end
