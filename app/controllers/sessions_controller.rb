class SessionsController < ApplicationController
get '/login'do 
  redirect_if_logged_in
    erb :"sessions/login"
  end

  post '/login' do
    user = User.find_by_username(params[:username])
    if user && user.authenticate(params[:password])
      flash[:success]="You've successfully logged in!"
      session[:user_id]= user.id 
      redirect "/users/#{user.id}"
    else
      flash[:error]= "Invaild login information."
      redirect "/login"
    end
  end

  get '/logout' do
  session.clear
  redirect "/login"
  end
end