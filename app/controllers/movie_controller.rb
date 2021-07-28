class MovieController < ApplicationController

    get '/movies' do
        
        if logged_in?
        @user = current_user
        @movies = Movie.unique_movies
        erb :"movies/index"
        else   
            redirect to "/login"
        end
    end

    get '/movies/:slug' do 
        @movie = Movie.find_by_slug(params[:slug])
        erb :"movies/show"
    end

end