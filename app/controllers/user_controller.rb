require 'rack-flash'

class UserController < ApplicationController 
    use Rack::Flash
      
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
            @user = User.new(params[:user])
            if @user.save && !@user.username.include?(" ")
            session[:user_id] = @user.id
            redirect to "/users/#{@user.slug}"
            else
            flash[:error] = "please enter a valid password and unique username. Usernames cannot include spaces."
            redirect to "/register"
            end
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
                flash[:error] = "Please enter valid username and password or register for an account."
                redirect to "/login"
            end
        end
    end

    get '/logout' do 
    if logged_in?
            session.destroy
            redirect to '/'
        else 
            redirect to '/'
        end
    end
    
    get '/users/:slug' do
        @user = User.find_by_slug(params[:slug])
        if logged_in? && @user.id == current_user.id   
            erb :"movies/show"
        else 
            redirect to "/login"
        end
    end

end