class MovieController < ApplicationController

    get '/movies' do 
        @movies = Movie.unique_movies
        erb :"movies/index"
    end

    get '/movies/:slug' do 
        @movie = Movie.find_by_slug(params[:slug])
        erb :"movies/show"
    end

end