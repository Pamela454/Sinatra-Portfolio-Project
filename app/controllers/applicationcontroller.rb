require './config/environment'

class ApplicationController < Sinatra::Base

  configure do
    set :public_folder, 'public'
    set :views, 'app/views'
    enable :sessions  #stores users ID, enables sessions
    set :session_secret, "physician_editor"
  end

  get "/" do
    @physician = Physician.find_by(id: session[:id])
    @patient = Patient.find_by(id: session[:id])
    erb :index
  end

  helpers do
		def logged_in?
			session[:id] != nil
		end
  end

   def physician_user?
     Physician.find_by(username: session[:username])
   end

   def patient_user?
     Patient.find_by(username: session[:username])
   end

end
