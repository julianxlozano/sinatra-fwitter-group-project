class TweetsController < ApplicationController

    
    get '/tweets' do 
        if Helpers.is_logged_in?(session)
        @tweets = Tweet.all 
        erb :'/tweets/index'
        else 
          redirect :'/login'
        end
      end

    get '/tweets/new' do 
       # binding.pry 
        erb :'/tweets/new'
    end

    get '/tweets/:id' do 
        #  binding.pry 
          @tweet = Tweet.find(params[:id])
          erb :'tweets/show'
      end
    

    post '/tweets' do 
       # binding.pry
        if !params[:content].empty?
        @tweet = Tweet.create(content:params[:content],user_id:session[:user_id])
        @tweet.save 
        redirect :"/tweets/#{@tweet.id}"
        else 
            redirect :'/tweets/new'
        end
    end

    get '/tweets/:id/edit' do 
     #  binding.pry 
      
        @tweet = Tweet.find(params[:id])
        if session[:user_id] == @tweet.user_id 
        erb :"tweets/edit" 
       else
        redirect '/tweets'
       end
    end

    post '/tweets/:id' do 
      # binding.pry
        if !params[:content].empty?
            @updated_tweet = Tweet.update(params[:id],content:params[:content])
            @updated_tweet.save 
            redirect :"/tweets/#{@params[:id]}"
            else 
            redirect :"/tweets/#{params[:id]}/edit"
            end
    end

    delete '/tweets/:id/delete' do 
    #  binding.pry 
     
      @tweet = Tweet.find_by_id(params[:id])
      if session[:user_id] == @tweet.user_id 
      @tweet.delete
      redirect '/tweets'
      else 
        redirect '/tweets'
      end
    end

end
