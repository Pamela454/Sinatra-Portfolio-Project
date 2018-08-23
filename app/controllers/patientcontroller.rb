require 'sinatra/base' #is this necessary?
require 'rack-flash'
#every controller action happens in isolation.
class PatientController < ApplicationController
    use Rack::Flash

  get '/patients/login' do
    if logged_in?
      redirect "/patients/show"  #needs to be restful route
    else
      flash[:message] = "Please login to your profile."
      erb :"/patients/login" #forms send data to the server
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

  get '/patients/:id' do  #creating a route variable. should always be after patients/new route
    @patient = Patient.find_by(id: session[:user_id])
    #session[:user_id] = @patient.id
      if session[:user_id] != nil
        flash[:message] = "Successfull login."
        erb :"/patients/show"
      else
        redirect '/patients/login'
      end
  end

  #post '/patients/:id' do

  #end

  get '/logout' do
      session.clear
      redirect "/patients/login"
  end
end
