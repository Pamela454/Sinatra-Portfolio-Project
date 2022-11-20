# frozen_string_literal: true

require 'sinatra/base'
require 'rack-flash'
# app/controllers/applicationcontroller.rb
class PatientsController < ApplicationController
  use Rack::Flash

  get '/patients/signup' do
    if current_user.instance_of?(Patient)
      flash[:message] = 'You do not have access to that feature.'
      redirect '/patients/signup'
    else
      @new_user = Patient.create(username: params[:username], password: params[:password])
      erb :"/patients/create_patient"
    end
  end

  post '/patients/signup' do
    if params[:username] == '' || params[:password] == ''
      flash[:message] = 'Please enter a username and password to create a new patient.'
      redirect '/patients/signup'
    else
      @new_user = Patient.create(username: params[:username], password: params[:password])
      if @new_user.save
        session[:id] = @new_user.id
        flash[:message] = 'Successful creation of profile.'
        redirect "/patients/#{@new_user.id}"
      else
        flash[:message] = 'Not valid profile data.'
      end
      redirect '/patients/login'
    end
  end

  get '/patients/login' do
    if current_user.instance_of?(Patient)
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
    if @patient&.authenticate(params[:password])
      session[:username] = params[:username]
      session[:id] = @patient.id
      session[:user_type] = 'patient'
      redirect "/patients/#{@patient.id}"
    else
      flash[:message] = 'Could not authenticate login.'
      redirect '/patients/login'
    end
  end

  get '/patients/new' do
    if session[:user_type] == "physician"
      erb :"/patients/new"
    else
      flash[:message] = 'You do not have access to that feature.'
      redirect '/'
    end
  end

  post '/patients/new' do
    if params[:username].nil? && params[:password].nil?
      flash[:message] = 'Please enter both username and password to create a new patient.'
      redirect '/patients/new'
    else
      params[:username] && !params[:password].nil?
      @patient = Patient.create(username: params[:username], password: params[:password], physician_id: session[:id],
                                medical_history: params[:medical_history], active_problems: params[:active_problems])
      if @patient.save
        @physician = Physician.find_by(id: session[:id])
        @patients = @physician.patients
        flash[:message] = 'Successfully added new patient.'
        erb :"/physicians/show"
      else
        flash[:message] = 'Not valid profile data.'
        redirect '/patients/new'
      end
    end
  end

  get '/patients/:id' do
    if session[:user_type] == 'patient' && session[:id] == params[:id].to_i
      @patient = Patient.find_by(id: session[:id])
      @measurements = @patient.measurements
      flash[:message] = 'Successful login.'
      erb :"/patients/show"
    elsif session[:user_type] == nil && session[:id] != nil
      @patient = Patient.find_by(id: session[:id])
      session[:user_type] = "patient"
      erb :"/patients/show"      
    else
      flash[:message] = 'You do not have access to that feature.'
      erb :"/patients/login"
    end
  end

  get '/patients/:id/edit' do
    if current_user.instance_of?(Physician)
      @patient = Patient.find_by(id: params[:id])
      erb :"/patients/edit"
    else
      flash[:message] = 'You do not have access to that feature.'
      redirect '/patients/login'
    end
  end

  patch '/patients/:id' do
    @patient = Patient.find_by(username: params[:username])
    @physician = Physician.find_by(id: session[:id])
    @patient.update_attribute(:medical_history, params[:medical_history]) if params[:medical_history] != ''
    @patient.update_attribute(:active_problems, params[:active_problems]) if params[:active_problems] != ''
    flash[:message] = 'Successfully edited patient profile.'
    redirect "/physicians/#{@physician.id}"
  end

  delete '/patients/:id/delete' do
    current_user
    if @current_user.nil?
      flash[:message] = 'You do not have access to that feature.'
      redirect '/'
    elsif current_user.instance_of?(Patient)
      Patient.find_by(username: session[:username])
      flash[:message] = 'You are not permitted to delete this patient.'
      redirect "/physicians/#{@physician.id}"
    elsif current_user.instance_of?(Physician)
      @physician = Physician.find_by(username: session[:username])
      @patient = Patient.find_by(id: params[:id])
      @patient.delete
      redirect "/physicians/#{@physician.id}"
    end
  end

  get '/patients/:id/measurement' do 
    if current_user.instance_of?(Patient)
      @patient = Patient.find_by(id: params[:id])
      erb :"/patients/measurement"
    else
      flash[:message] = 'You do not have access to that feature.'
      redirect "/patients/#{@patient.id}"
    end
  end

  post '/patients/:id/measurement' do 
    binding.pry 
    @patient = Patient.find_by(id: params[:id])
     if params[:blood_pressure] && !params[:heart_rate].nil?
      @measurement = Measurement.create(blood_pressure: params[:blood_pressure], heart_rate: params[:heart_rate], date_time: DateTime.now, patient_id: params[:id])
      flash[:message] = 'Successfully added new blood pressure/heart rate.'
      redirect "/patients/#{@patient.id}"
     else
      flash[:message] = 'Please enter a valid measurement.'
      redirect "/patients/#{@patient.id}"
     end
  end

  get '/logout' do
    session.clear
    redirect '/'
  end
end
