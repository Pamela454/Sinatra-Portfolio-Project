require './config/environment'

class ApplicationController < Sinatra::Base
#routes defined in the controller 
  configure do
    set :public_folder, 'public' #directory where static files should be served from. 
    set :views, 'app/views' #specify directory where view templates are located 
    enable :sessions  #stores users ID, enables sessions. keeps state during requests. 
    set :session_secret, ENV.fetch('SESSION_SECRET') { SecureRandom.hex(64) }
  end 

  get "/" do
    erb :index
  end

  helpers do

    def logged_in?
      !!current_user
    end

    def current_user #ternary operator, create local variable to pass around
      @current_user ||= session[:user_type] == "patient" ? #current_user or session user == patient?
        Patient.find_by(username: session[:username]) :
        Physician.find_by(username: session[:username])
    end
  end
end
