require './config/environment'

class ApplicationController < Sinatra::Base

  configure do
    set :public_folder, 'public'
    set :views, 'app/views'
  end

  get '/' do
    erb :home
  end

  get '/signup' do
    erb :"registrations/signup"
  end

  post '/signup' do
    binding.pry
    user = User.create(params)
    if user.valid?
      session[:user_id]= user.id 
      redirect "/users/#{user.id}"
    else
      # flash[:error]=user.errors
      redirect "/signup"
    end
  end 

  get '/login'do 
    erb :"sessions/login"
  end

  post 'signup' do
    params.to_s
  end

end
