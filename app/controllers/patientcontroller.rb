require 'sinatra/base'
require 'rack-flash'

class PatientController < ApplicationController
    use Rack::Flash

    get '/patients/login' do
        if patient_user?
          @patient = Patient.find_by(username: params[:username])
          session[:user_id] = @patient.id
          erb :"/patients/show"
        else
          flash[:message] = "Please login to your profile."
          erb :"/patients/login"
        end
    end

    post '/patients/login' do
      @patient = Patient.find_by(username: params[:username])
      session[:id] = @patient.id
      session[:username] = params[:username]
      #raise @patient.inspect
        if @patient != nil
            redirect "/patients/#{@patient.id}"
        else
            redirect '/patients/login'
        end
    end

    get '/patients/new' do
      if physician_user?
        erb :"/patients/new"
      else
        flash[:message] = "You do not have access to that feature."
        redirect '/'
      end
    end


    post '/patients/new' do
       params[:username] && params[:password] != nil
       @patient = Patient.create(username: params[:username], password: params[:password], physician_id: session[:id],
         medical_history: params[:medical_history], active_problems: params[:active_problems])
       @patient.save
       @physician = Physician.find_by(id: session[:id])
       @patients = @physician.patients
       erb :"/physicians/show"
   end


  get '/patients/:id' do  #creating a route variable. should always be after patients/new route
      if patient_user? && session[:id] == params[:id].to_i
        @patient = Patient.find_by(id: session[:id])
        flash[:message] = "Successful login."
        erb :"/patients/show"
      else
        erb :"/patients/login"
      end
  end

  get '/patients/:id/edit' do
    if physician_user?
      @patient = Patient.find(params[:id])
      erb :"/patients/edit"
    else
      flash[:message] = "You do not have access to that feature."
      redirect '/patients/login'
    end
  end

  post "/patients/:id" do
    @patient = Patient.find_by(username: params[:username])
    @physician = Physician.find_by(id: session[:id])
    if params[:medical_history] != ""
      @patient.update_attribute(:medical_history, params[:medical_history])
    end
    if params[:active_problems] != ""
      @patient.update_attribute(:active_problems, params[:active_problems])
    end
      flash[:message] = "Welcome to your physician page. Please find your patients listed below:"
      redirect "/physicians/#{@physician.id}"
    #else
    #  flash[:message] = "Information supplied does not meet requirements. Please try again."
    #  redirect "/patients/#{@patient.id}/edit"
    #end
  end

  delete "/patients/:id/delete" do
    @patient = Patient.find_by(id: params[:id])
    @physician = Physician.find_by(id: session[:id])

    if !logged_in?
      flash[:message] = "You do not have access to that feature."
      redirect "/"
    elsif !physician_user?
      flash[:message] = "You are not permitted to delete this patient."
      redirect "/physicians/#{@physician.id}"
    else
      @patient.delete
      redirect "/physicians/#{@physician.id}"
    end
  end

  get '/logout' do
      session.clear
      redirect "/"
  end
end
