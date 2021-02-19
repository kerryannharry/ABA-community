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
    erb :signup
  end

  post '/signup' do
    params.to_s
  end 

end
