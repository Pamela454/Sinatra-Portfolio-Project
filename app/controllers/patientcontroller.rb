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

  post "/patients/:id" do
    @patient = Patient.find_by(id: params[:id])
    @physician = Physician.find_by(id: session[:id])
    if params[:username] && params[:password] != nil
      @patient.save
      flash[:message] = "Welcome to your physician page. Please find your patients listed below:"
      redirect "/physicians/#{@physician.id}"
    else
      flash[:message] = "Information supplied does not meet requirements. Please try again."
      redirect "/patients/#{@patient.id}/edit"
    end
  end

  delete "/patients/:id/delete" do
    @patient = Patient.find_by(id: params[:id])
    @physician = Physician.find_by(id: session[:id])

    if !logged_in?
      redirect "/"
    elsif @patient.physician_id != @physician.id
      flash[:message] = "You are not permitted to delete this patient."
      redirect "/physicians/#{@physician.id}"
    else
      @patient.delete
      redirect "/physicians/#{@physician.id}"
    end
  end

  get '/logout' do
      session.clear
      redirect "/"
  end
end
