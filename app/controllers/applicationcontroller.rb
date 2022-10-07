# frozen_string_literal: true

require './config/environment'
require 'securerandom'
require 'sinatra'
# app/controllers/applicationcontroller.rb
class ApplicationController < Sinatra::Base
  configure do
    set :public_folder, 'public'
    set :views, 'app/views'
    use Rack::Session::Cookie
    set :session_secret, ENV.fetch('SESSION_SECRET') { SecureRandom.hex(64) }
  end

  get '/' do
    erb :index
  end

  get '/logout' do
    session.clear
    redirect '/'
  end

  helpers do
    def logged_in?
      !!current_user
    end

    def current_user
      if session[:user_type].nil?
        session[:user_type] == 'none'
      else
        @current_user ||= if session[:user_type] == 'patient'
                            Patient.find_by(username: session[:username])
                          else
                            Physician.find_by(username: session[:username])
                          end
      end
    end
  end
end
