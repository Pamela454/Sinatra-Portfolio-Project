require 'sinatra/base' #is this necessary?
require 'rack-flash'
#every controller action happens in isolation.
class PatientController < ApplicationController
    use Rack::Flash

  get '/patients/login' do
    if logged_in?
      redirect "/patients/show"  #needs to be restful route
    else
      erb :"/patients/login" #forms send data to the server
    end
  end

  get "/patients/new" do
    if logged_in?
        erb :"/patients/new"
    else
      redirect "/"
    end
  end

  get '/patients/:id' do  #creating a route variable. should always be after patients/new route
      #raise params.inspect
      @patient.id = params[:id]
      @patient.username = params[:username]
      erb :"/patients/show"
  end

  post '/patients' do
      @new_patient = Patient.new(username: params[:username], password: params[:password])

      if @new_patient.save
      redirect "/books/#{@new_patient.id}"
    else
      flash[:message] = "Error: Invalid Patient Info"
      redirect "/patients/new"
    end
  end

  get '/logout' do
      session.clear
      redirect "/patients/login"
  end
end
