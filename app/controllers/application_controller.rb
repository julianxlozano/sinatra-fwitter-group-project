require './config/environment'

class ApplicationController < Sinatra::Base

  configure do
    set :public_folder, 'public'
    set :views, 'app/views'
    enable :sessions
   set :session_secret, "secret"
  end

  get '/' do 
    erb :index
  end

  get '/signup' do 
    erb :signup
  end

  post '/signup' do 
    if Helpers.is_logged_in?(session)
      redirect :'/tweets'
    else
    @user = User.new(username: params["username"], email: params["email"], password: params["password"])
    
    #binding.pry
    if @user.save && !@user.username.empty? && !@user.email.empty?
      @user.save 
       session[:user_id] = @user.id
       redirect :'/tweets'
    else 
       redirect :'/signup'
    end

  end
  end









end
