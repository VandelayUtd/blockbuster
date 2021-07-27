class MemberController < ApplicationController 

    get '/register' do 
        erb :"members/register"
    end

    post '/register' do 
        @member = Member.create(params[:member])
        redirect to "/login"
    end

    get '/login' do 
        erb :"members/login"
    end
    
    get '/members/:slug' do 
        @member = Member.find_by_slug(params[:slug])
        erb :"members/show"
    end

    post '/login' do 
        @member = Member.find_by(username: params[:member][:username])
        
        if @member && @member.authenticate(params[:member][:password])
                session[:user_id] = @member.id
                redirect to "/members/#{@member.slug}"
        else
            redirect to "/register"
        end
    end

   

end