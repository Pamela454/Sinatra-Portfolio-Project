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

    if @new_user.save
      session[:id] = @new_user.id
      redirect "/patients"
    else
      erb :"/physicians/create_physician"
    end

  end

  get '/physicians/login' do
    if logged_in?
      redirect "/patients"  #needs to be restful?
    else
      erb :"/physicians/login"
    end
  end

  post '/login' do
    @physician = Physician.find_by(username: params[:username])
      if @physician && @physician.authenticate(params[:password])
          session[:physician_id] = @physician.id
          redirect '/patients'
      else
          redirect '/physicians/login'
      end
    end

    get '/logout' do
      session.clear
      redirect "/login"
    end

end
