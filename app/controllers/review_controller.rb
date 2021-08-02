class ReviewController < ApplicationController

    get '/reviews' do 
        @user = current_user         
        erb :"reviews/index"
    end

    get '/reviews/new/:slug' do
        @movie = Movie.find_by_slug(params[:slug])
        erb :"reviews/new"
    end

    post '/reviews/:slug' do
        user_review = current_user.reviews.build(comment: params[:comment], rating: params[:rating])
        movie = Movie.find_by_slug(params[:slug])
        movie.reviews << user_review
        redirect to "/movies/#{movie.slug}"
    end

    get '/reviews/:id/edit' do
        @review = Review.find_by(id: params[:id])
       
        erb :"reviews/edit"
    end

    patch '/reviews/:id' do
        @review = Review.find_by(id: params[:id])
        @review.comment = params[:comment]
        @review.rating = params[:rating]
        @review.save
        redirect to "/movies/#{@review.movie.slug}"
    end

    delete '/reviews/:id/delete' do 
        @review = Review.find_by(id: params[:id])
        movie = @review.movie
        @review.delete
        redirect to "/movies/#{movie.slug}"
    end
    
    
end