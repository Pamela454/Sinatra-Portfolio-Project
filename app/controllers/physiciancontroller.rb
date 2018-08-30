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
    @new_user.save
    if @new_user != ""
      flash[:message] = "Successfully created profile."
      redirect "/physicians/login"
    else
      flash[:message] = "Information supplied does not meet requirements. Please try again."
      erb :"/physicians/create_physician"
    end
  end

  get "/physicians/login" do
    @patients = Patient.all
      erb :"/physicians/login"
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

  get '/logout' do
    session.clear
    redirect "/"
  end
end
