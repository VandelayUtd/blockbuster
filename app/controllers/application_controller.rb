require './config/environment'

class ApplicationController < Sinatra::Base
  register Sinatra::ActiveRecordExtension

  configure do
    set :public_folder, 'public'
    set :views, 'app/views'
    use Rack::Session::Cookie, :key => 'rack.session',
    :path => '/',
    :secret => 'your_secret'
  end


  get "/" do
    if logged_in?
      redirect to "/members/#{current_user.slug}"
    else    
      erb :index
    end
  end

  helpers do 
    def logged_in? 
      !!current_user
    end

    def current_user
      @current_user ||= Member.find_by(id: session[:user_id]) if session[:user_id]
    end
  end

end
