class MovieController < ApplicationController


    

    get '/movies' do  
        if logged_in?
        @user = current_user
        @movies = Movie.list.select 
        erb :"movies/index"
        else   
            redirect to "/login"
        end
    end

    post '/movies' do
        if logged_in?
            @user = User.find_by(id: session[:user_id])
            movie_ids = params[:user][:movie_ids]
            movie_ids.each do |movie_id|
                movie = Movie.find_by(id: movie_id)
                @user.movies << movie 
                movie.inventory -= 1
                movie.save
            end
            redirect to "/users/#{@user.slug}"
        else
            redirect to "/login"
        end
    end

    get "/return" do
        if logged_in?
            @user = current_user
            erb :"movies/return"
        else 
            redirect to "/login"
        end
    end

    get "/movies/:slug/reviews" do
        if logged_in?
            @movie = Movie.find_by_slug(params[:slug])
            @user = current_user
            erb :"movies/movie_reviews"
        else 
            redirect to "/login"
        end
    end

    patch '/return' do
        if logged_in?
            @user = current_user
            movie_ids = params[:user][:movie_ids]
            
            movie_ids.each do |id| 
                movie = @user.movies.find_by(id: id)
                if !movie.nil? 
                movie.inventory += movie_ids.count{|i| i == movie.id.to_s}
                movie.save
                @user.movies.delete(movie)
                end
            end
            erb :"movies/show"
        else
            redirect to "/login"
        end
    end
  
    

    get '/movies/:slug' do
        if  logged_in?
            flash[:message] = "Out of Stock"
            @movie = Movie.all.find_by_slug(params[:slug])
            @vhs = Movie.all.select{|movie| movie.format == "VHS" && movie.title == @movie.title}.first
            @dvd = Movie.all.select{|movie| movie.format == "DVD" && movie.title == @movie.title}.first
            erb :"movies/new"
        else 
            redirect to "/login"
        end
    end
end