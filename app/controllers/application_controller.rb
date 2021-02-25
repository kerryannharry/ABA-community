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

  

helpers do 
  def current_user
    @current_user ||= User.find_by_id(session[:user_id]) if session[:user_id]
  end

  def logged_in?
    !!current_user
  end

  def redirect_if_not_logged_in
    if !logged_in? 
      redirect "/login"
    end
  end
  def redirect_if_logged_in
    if logged_in? 
      redirect "/users/#{current_user.id}"
    end
  end
end
end
