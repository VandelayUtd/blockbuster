class MovieController < ApplicationController

    get '/movies' do
        
        if logged_in?
        @user = current_user
        @movies = Movie.list
        erb :"movies/index"
        else   
            redirect to "/login"
        end
    end

    get '/movies/:slug' do
        @movie_dvds = Movie.dvd_instock
        @movie_vhs = Movie.vhs_instock
        @movie = Movie.instock.find_by_slug(params[:slug])
        @vhs = @movie_vhs.find_by_slug(params[:slug])
        @dvd = @movie_dvds.find_by_slug(params[:slug])
        erb :"movies/show"
    end

    get'/return/' do
        @user = current_user
        erb :"movies/return" 
        
        
        
        # @movie = Movie.find_by(id: params[:id])
        # @user = current_user
        # binding.pry

        # @movie.user_id = nil
        # @movie.delete
        # redirect to "/users/#{@user.slug}"
    end

end