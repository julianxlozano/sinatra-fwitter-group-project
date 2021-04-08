class UsersController < ApplicationController

    get '/login' do 
        erb :login
      end
    
      post '/login' do 
       # binding.pry 
       @user = User.find_by(username: params[:username])
        if @user && @user.authenticate(params[:password])
          session[:user_id] = @user.id
          redirect :'/tweets'
        else
          redirect :'/'
        end
      end

      get '/logout' do 
        session.clear 
        redirect :'/login'
      end

      get '/users/:username' do 
   #    binding.pry 
        @user = User.find_by(username:params[:username])
        @tweets = Tweet.all 
        erb :'/users/show'
      end 
end
