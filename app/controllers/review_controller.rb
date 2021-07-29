class ReviewController < ApplicationController
    get '/reviews' do 
        erb :"reviews/show"
    end

    get '/reviews/new' do 
        erb :"reviews/new"
    end

    post '/revews' do 
        
    end
end