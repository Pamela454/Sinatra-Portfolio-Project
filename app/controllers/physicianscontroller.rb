require 'sinatra/base' #is this necessary?
require 'rack-flash'

class PhysiciansController < ApplicationController
  use Rack::Flash

  get "/physicians/signup" do
    if self.current_user.class == Patient
      flash[:message] = "You do not have access to that feature."
      redirect '/patients/:id'
    else
      @new_user = Physician.create(username: params[:username], npi: params[:npi], password: params[:password])
      erb :"/physicians/create_physician"
    end
  end

  post "/physicians/signup" do
    if params[:username] == "" || params[:npi] == "" || params[:password] == ""
      flash[:message] = "Please enter a username, password, and npi to create a new physician."
      redirect "/physicians/signup"
    else
      @new_user = Physician.create(username: params[:username], npi: params[:npi], password: params[:password])
      #grab data from params hash and save as a new user
      if @new_user.save
        session[:id] = @new_user.id
        flash[:message] = "Successful creation of profile. Please log in."
        redirect "/physicians/login"
      else
        flash[:message] = "Not valid profile data."
        redirect "/physicians/login"
      end
    end
  end

  get "/physicians/login" do #only physicians can log in here
    @patients = Patient.all
    erb :"/physicians/login"
  end


  post '/physicians/login' do
    @physician = Physician.find_by(username: params[:username])
    if @physician && @physician.authenticate(params[:password]) #check to see if password matches stored password
      session[:id] = @physician.id
      session[:user_type] = "physician"
      session[:username] = params[:username]
      current_user
      #session[:id] = @physician.id  #session hash persists throughout session. Any controller can access.
      flash[:message] = "Successful login."
      redirect "/physicians/#{@physician.id}"
    else
      flash[:message] = "Incorrect login information"
      redirect '/physicians/login'
    end
  end


  get "/physicians/:id" do
    #second authentication check 
    if self.current_user.class == Physician && session[:id] == params[:id].to_i
      @physician = Physician.find_by(id: params[:id])
      @patients = @physician.patients
      erb :"/physicians/show"
    else
      flash[:message] = "You do not have access to that page."
      redirect "/physicians/login"
    end
  end

  get '/logout' do
    session.clear
    redirect "/"
  end
end
