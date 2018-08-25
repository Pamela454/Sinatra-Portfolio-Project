require 'sinatra/base' #is this necessary?
require 'rack-flash'

class PhysicianController < ApplicationController
    use Rack::Flash

  get "/physicians/signup" do
    if logged_in?
      redirect '/physicians/:id'
    else
      erb :"/physicians/create_physician"  #render when current request has data that we need
    end
  end

  post "/physicians/signup" do #maintain restful convention
    @new_user = Physician.create(username: params[:username], npi: params[:npi], password: params[:password])
    #grab data from params hash and save as a new user
    if @new_user != nil
      flash[:message] = "Successfully created profile."
      erb :"/physicians/add_patients"
    else
      flash[:message] = "Information supplied does not meet requirements. Please try again."
      erb :"/physicians/create_physician"
    end
  end

  get "/physicians/login" do
    @patients = Patient.all
    if logged_in?
      erb :"physicians/show"
    else
      erb :"/physicians/login"
    end
  end

  post '/physicians/login' do
    @physician = Physician.find_by(username: params[:username])
      if @physician && @physician.authenticate(params[:password])
          session[:id] = @physician.id  #session hash persists throughout session. Any controller can access.
          flash[:message] = "Successful login."
          redirect "/physicians/#{@physician.id}"
      else
          redirect '/physicians/login'
      end
    end

    get "/physicians/:id" do
    if logged_in?
      @physician = Physician.find_by(id: params[:id])
      @patients = @physician.patients
      erb :"/physicians/show"
    else
      redirect "/physicians/login"
    end
  end

  get "/physicians/:id/edit" do
    @physician = Physician.find_by(id: params[:id])

    if !logged_in?
      redirect "/physicians/login"
    elsif current_user.id == @physician.physician_id
      erb :"/physicians/edit_physician"
    else
      redirect "/physicians/show"
    end
  end

post "/patients/:id" do
  @patient = Patient.find_by(id: params[:id])

  if params[:content] != ""
    @patient.content = params[:content]
    @patient.save
    flash[:message] = "Welcome to your physician page. Please find your patients listed below:"
    redirect "/patients/#{@patient.id}"
  else
    redirect "/patients/#{@patient.id}/edit"
  end
end

  get '/logout' do
    session.clear
    redirect "/"
  end
end
