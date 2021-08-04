class ReviewController < ApplicationController

    get '/reviews' do 
        if logged_in?
            @user = current_user         
            erb :"reviews/index"
        else 
            redirect to "/login"
        end
    end

    get '/reviews/new/:slug' do
        if logged_in? 
            @movie = Movie.find_by_slug(params[:slug])
            erb :"reviews/new"
        else   
            redirect to "/login"
        end
    end

    post '/reviews/:slug' do
        if logged_in?
            user_review = current_user.reviews.build(comment: params[:comment], rating: params[:rating])
            movie = Movie.find_by_slug(params[:slug])
            movie.reviews << user_review
            redirect to "/movies/#{movie.slug}"
        else
            redirect to "/login"
        end
    end

    get '/reviews/:id/edit' do
        if logged_in?
            @review = Review.find_by(id: params[:id])
            movie = @review.movie
            if @review && @review.user == current_user
                erb :"reviews/edit"
            else
                flash[:error] = "You can't edit another user's review."
                redirect "/movies/#{movie.slug}"
            end
        else  
            redirect to "/login"
        end
    end

    patch '/reviews/:id' do
        if logged_in? &&  
            @review = Review.find_by(id: params[:id])
            @review.comment = params[:comment]
            @review.rating = params[:rating]
            @review.save
            redirect to "/movies/#{@review.movie.slug}"
        else 
            redirect to "/login"
        end
    end

    delete '/reviews/:id/delete' do
        if logged_in? 
            @review = Review.find_by(id: params[:id])
            movie = @review.movie
            @review.delete
            redirect to "/movies/#{movie.slug}"
        else 
            redirect to "/login"
        end
    end
    
end