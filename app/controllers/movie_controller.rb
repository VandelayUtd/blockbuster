class MovieController < ApplicationController


    

    get '/movies' do  
        if logged_in?
        @user = current_user
        @movies = Movie.list.select{|movie| movie.user_id == nil} 
        erb :"movies/index"
        else   
            redirect to "/login"
        end
    end

    get"/return" do
        @user = current_user
        erb :"movies/return"    
    end

    patch '/return' do
        @user = current_user
        movie_ids = params[:user][:movie_ids]
        movie_ids.each do |id|
            movie = @user.movies.find_by(id: id)
            movie.update(user_id: nil)
        end
        erb :"movies/show"
    end
  
    post '/movies' do
        if logged_in?
            @user = User.find_by(id: session[:user_id])
            movie_ids = params[:user][:movie_ids]
            movie_ids.each {|movie_id| @user.movies.push( Movie.find_by(id: movie_id))}
            redirect to "/users/#{@user.slug}"
        else
            redirect to "/login"
        end
    end

    get '/movies/:slug' do
        if  logged_in? 
            @movie = Movie.instock.find_by_slug(params[:slug])
            @vhs = Movie.instock.select{|movie| movie.format == "VHS" && movie.title == @movie.title}.first
            @dvd = Movie.instock.select{|movie| movie.format == "DVD" && movie.title == @movie.title}.first
            # binding.pry
            erb :"movies/new"
        else 
            redirect to "/login"
        end
    end
end