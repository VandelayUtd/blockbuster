class MemberController < ApplicationController 

    get '/register' do
        if logged_in? 
            @member = current_user
            redirect to "/members/#{@member.slug}"
        else
            erb :"members/register"
        end
    end

    post '/register' do
        if logged_in?
            redirect to "/members/#{current_user.slug}"
        else
            @member = Member.create(params[:member])
            session[:user_id] = @member.id
            redirect to "/members/#{@member.slug}"
        end
    end

    get '/login' do
        if logged_in?
            @member = current_user
            redirect to "/members/#{@member.slug}"
        else
            erb :"members/login"
        end
        
    end
   
    get '/members/:slug' do
        if logged_in?
            @member = Member.find_by_slug(params[:slug])
            erb :"members/show"
        else 
            redirect to "/login"
        end
    end
    
    post '/login' do
        if logged_in?
             @member = current_user
        else 
            @member = Member.find_by(username: params[:member][:username])
            if @member && @member.authenticate(params[:member][:password])
                    session[:user_id] = @member.id
                    redirect to "/members/#{@member.slug}"
            else
                redirect to "/register"
            end
        end
    end

    post '/members' do
        @member = Member.find_by(id: session[:user_id])
        movie = Movie.find_by(id: params[:member][:movie_id])
        @member.movies << movie
        redirect to "/members/#{@member.slug}"
    end     
    


end