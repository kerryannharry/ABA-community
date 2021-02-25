class UsersController < ApplicationController
get '/signup' do
    redirect_if_logged_in
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
erb:"users/show"
  end
end