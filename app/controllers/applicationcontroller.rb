require './config/environment'

class ApplicationController < Sinatra::Base

  configure do
    set :public_folder, 'public'
    set :views, 'app/views'
    enable :sessions  #stores users ID, enables sessions. keeps state during requests. 
    set :session_secret, 
  end

  get "/" do
    @physician = Physician.find_by(id: session[:id])
    @patient = Patient.find_by(id: session[:id])
    erb :index
  end

  helpers do

    def current_user #ternary operator, create local variable to pass around
      @current_user ||= session[:user_type] == "patient" ? #current_user or session user == patient?
        Patient.find_by(username: session[:username]) :
        Physician.find_by(username: session[:username])
    end

  end
end
