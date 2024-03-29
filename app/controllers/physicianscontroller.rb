# frozen_string_literal: true

require 'sinatra/base'
require 'rack-flash'
# app/controllers/applicationcontroller.rb
class PhysiciansController < ApplicationController
  use Rack::Flash

  get '/physicians/signup' do
    if current_user.instance_of?(Patient)
      flash[:message] = 'You do not have access to that feature.'
      redirect '/patients/:id'
    else
      erb :"/physicians/create_physician"
    end
  end

  post '/physicians/signup' do
    if params[:username] == '' || params[:npi] == '' || params[:password] == ''
      flash[:message] = 'Please enter a username, password, and npi to create a new physician.'
      redirect '/physicians/signup'
    else
      @new_user = Physician.create(username: params[:username], npi: params[:npi], password: params[:password])
      if @new_user.save
        session[:id] = @new_user.id
        flash[:message] = 'Successful creation of profile.'
        redirect "/physicians/#{@new_user.id}"
      else
        flash[:message] = 'Not valid profile data.'
      end
      redirect '/physicians/login'
    end
  end

  get '/physicians/login' do
    @patients = Patient.all
    erb :"/physicians/login"
  end

  post '/physicians/login' do
    @username = params[:username]
    @physician = Physician.find_by(username: @username)
    if @physician.authenticate(params[:password])
      session[:id] = @physician.id
      session[:user_type] = 'physician'
      session[:username] = params[:username]
      binding.pry 
      current_user
      binding.pry 
      flash[:message] = 'Successful login.'
      redirect "/physicians/#{@physician.id}"
    else
      flash[:message] = 'Incorrect login information'
      redirect '/physicians/login'
    end
  end

  get '/physicians/:id' do
    binding.pry 
    if current_user.instance_of?(Physician) && session[:id] == params[:id].to_i
      @physician = Physician.find_by(id: params[:id])
      @patients = @physician.patients
      erb :"/physicians/show" 
    elsif session[:user_type] == nil && session[:id] != nil
      @physician = Physician.find_by(id: session[:id])
      session[:user_type] = "physician"
      @patients = @physician.patients
      erb :"/physicians/show" 
    else
      flash[:message] = 'You do not have access to that page.'
      redirect '/physicians/login'
    end
  end
end
