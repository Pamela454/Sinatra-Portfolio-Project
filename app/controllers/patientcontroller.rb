require 'sinatra/base' #is this necessary?
require 'rack-flash'
#every controller action happens in isolation.
class PatientController < ApplicationController
    use Rack::Flash

  get '/patients/login' do
    if logged_in?
      erb :"/patients/show"
    else
      flash[:message] = "Please login to your profile."
      erb :"/patients/login"
    end
  end

  post '/patients/login' do
    @patient = Patient.find_by(username: params[:username])
    session[:user_id] = @patient.id
    #raise @patient.inspect
      if @patient != nil
          redirect '/patients/:id'
      else
          redirect '/patients/login'
      end
  end

  get '/patients/new' do
    if logged_in?
      erb :"/patients/new"
    else
      redirect '/login'
    end
  end

  post '/patients/new' do
      params[:username] && params[:password] != nil
      @patient = Patient.create(username: params[:username], password: params[:password])
      erb :"/physicians/show"
  end


  get '/patients/:id' do  #creating a route variable. should always be after patients/new route
    @patient = Patient.find_by(id: session[:user_id])
    #session[:user_id] = @patient.id
      if session[:user_id] != nil
        flash[:message] = "Successful login."
        erb :"/patients/show"
      else
        redirect '/patients/login'
      end
  end

  get '/patients/:id/edit' do
    @patient = Patient.find(params[:id])
    erb :"/patients/edit"
  end

  get '/logout' do
      session.clear
      redirect "/"
  end
end
