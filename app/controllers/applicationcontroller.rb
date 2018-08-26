require './config/environment'

class ApplicationController < Sinatra::Base

  configure do
    set :public_folder, 'public'
    set :views, 'app/views'
    enable :sessions  #stores users ID
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

		def patient_current_user
		  if session[:id]
			  Patient.find(session[:id])
			end
		end

    def physician_current_user
		  if session[:id]
			  Physician.find(session[:id])
			end
		end
  end

  
end
