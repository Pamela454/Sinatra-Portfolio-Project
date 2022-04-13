require './config/environment'
require 'securerandom'

class ApplicationController < Sinatra::Base

  configure do
    set :public_folder, 'public' 
    set :views, 'app/views' 
    use Rack::Session::Cookie 
    set :session_secret, ENV.fetch('SESSION_SECRET') { SecureRandom.hex(64) }
  end 

  get "/" do
    @session = session 
    erb :index
  end

  helpers do

    def logged_in?
      !!current_user
    end

    def current_user 
      if session[:user_type] == nil
        session[:user_type] == "none"
      else
        @current_user ||= session[:user_type] == "patient" ? 
        Patient.find_by(username: session[:username]) :
        Physician.find_by(username: session[:username])
      end
    end
  end
end
