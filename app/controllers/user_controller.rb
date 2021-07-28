require 'rack-flash'

class UserController < ApplicationController 
    use Rack::Flash

    get '/users/:slug' do
        if logged_in?
            @user = User.find_by_slug(params[:slug])
            erb :"users/show"
        else 
            redirect to "/login"
        end
    end
    
    get '/register' do
        if logged_in? 
            @user = current_user
            redirect to "/users/#{@user.slug}"
        else
            erb :"users/register"
        end
    end

    post '/register' do
        if logged_in?
            redirect to "/users/#{current_user.slug}"
        else
            @user = User.create(params[:user])
            session[:user_id] = @user.id
            redirect to "/users/#{@user.slug}"
        end
    end

    get '/login' do
        if logged_in?
            @user = current_user
            redirect to "/users/#{@user.slug}"
        else
            erb :"users/login"
        end
        
    end
    
    post '/login' do
        if logged_in?
             @user = current_user
        else 
            @user = User.find_by(username: params[:user][:username])
            if @user && @user.authenticate(params[:user][:password])
                    session[:user_id] = @user.id
                    redirect to "/users/#{@user.slug}"
            else
                redirect to "/register"
            end
        end
    end

    post '/users' do
        @user = User.find_by(id: session[:user_id])
        movie = Movie.find_by(id: params[:user][:movie_id])
        @user.movies << movie
        redirect to "/users/#{@user.slug}"
    end

    get '/logout' do 
    if logged_in?
            session.destroy
            redirect to '/'
        else 
            redirect to '/'
        end
    end
    


end