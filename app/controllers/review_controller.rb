class ReviewController < ApplicationController

    get '/reviews' do 
        @user = current_user
        erb :"reviews/index"
    end


    post '/reviews/:slug' do
        binding.pry
        user_review = current_user.reviews.build(comment: params[:comment], rating: params[:rating])
        movie = Movie.find_by_slug(params[:slug])
        movie.reviews << user_review
        redirect to "/reviews"
    end
        
    get "/reviews/:slug" do
        @movie = Movie.find_by_slug(params[:slug])
        @user = current_user
        erb :"reviews/show"
    end

    
    get '/reviews/:slug/new' do
        @movie = Movie.find_by_slug(params[:slug])
        erb :"reviews/new"
    end
end