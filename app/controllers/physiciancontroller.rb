require 'sinatra/base' #is this necessary?
require 'rack-flash'

class PhysicianController < ApplicationController
  enable :sessions
  use Rack::Flash

  get "/physicians/signup" do
    if logged_in?
      redirect '/physicians/login'
    else
      erb :"/physicians/create_physician"
    end
  end

  post "/physicians/signup" do
    @new_user = Physician.new(username: params[:username], npi: params[:npi], password: params[:password])
    #grab data from params hash and save as a new user
    if @new_user.save
      session[:id] = @new_user.id
      flash[:message] = "Successfully created profile."
      erb :"/physicians/show"
    else
      erb :"/physicians/create_physician"
    end

  end

  get '/physicians/login' do
    if logged_in?  #use helper method, needs to be physician specific
      redirect "/patients"  #needs to be restful?
    else
      erb :"/physicians/login"
    end
  end

  post 'physicians/login' do
    @physician = Physician.find_by(username: params[:username])
      if @physician && @physician.authenticate(params[:password])
          session[:id] = @physician.id
          flash[:message] = "Successfull login."
          redirect '/physicians/show'
      else
          redirect '/physicians/login'
      end
    end

    get "/physicians/:id" do
    if logged_in?
      @physician = Physician.find_by(id: params[:id])
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

  post "/physicians/:id" do
    @physician = Physician.find_by(id: params[:id])

    if params[:content] != ""
      @physician.content = params[:content]
      @physician.save
      redirect "/physicians/#{@physician.id}"
    else
      redirect "/physicians/#{@physician.id}/edit"
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
      redirect "/login"
    end

end
