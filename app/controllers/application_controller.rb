require './config/environment'

class ApplicationController < Sinatra::Base

  configure do
    set :public_folder, 'public'
    set :views, 'app/views'
    register Sinatra::Flash 
    enable :sessions
    set :session_secret, 'aba'
  end

  get '/' do
    erb :home
  end

  get '/signup' do
    erb :"registrations/signup"
  end

  post '/signup' do
    user = User.create(params)
    if user.valid?
      flash[:success]="Account sucessfully created!"
      session[:user_id]= user.id 
      redirect "/users/#{user.id}"
    else
      flash[:error]=user.errors.full_messages.to_sentence
      redirect "/signup"
    end
  end 

  get '/users/:id' do

  end

  get '/login'do 
    erb :"sessions/login"
  end

  post '/login' do
    user = User.save(params)
    if user.valid?
      flash[:success]="You've successfully logged in!"
      session[:user_id]= user.id 
      redirect "/users/#{user.id}"
    else
      flash[:error]=user.errors
      redirect "/login"
    end
  end

end
