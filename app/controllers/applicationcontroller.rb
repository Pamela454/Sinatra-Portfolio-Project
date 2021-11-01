require './config/environment'

class ApplicationController < Sinatra::Base
#routes defined in the controller 
  configure do
    set :public_folder, 'public'
    set :views, 'app/views'
    enable :sessions  #stores users ID, enables sessions. keeps state during requests. 
    set :session_secret, ENV.fetch('SESSION_SECRET') { SecureRandom.hex(64) }
  end  #this isn't used anywhere else? 

  get "/" do
    @physician = Physician.find_by(id: session[:id])
    @patient = Patient.find_by(id: session[:id])
    erb :index
  end

  helpers do

    def log_in
      binding.pry 
      if @patient != nil
        session[:id] = @patient.id 
      else 
        session[:id] = @physician.id 
      end
    end

    def current_user #ternary operator, create local variable to pass around
      binding.pry 
      @current_user ||= session[:user_type] == "patient" ? #current_user or session user == patient?
        Patient.find_by(username: session[:username]) :
        Physician.find_by(username: session[:username])
    end

    def user_type
      @current_user ||= session[:user_type] == "patient" ? #current_user or session user == patient?
        Patient.find_by(username: session[:username]) :
        Physician.find_by(username: session[:username])
    end

  end
end
