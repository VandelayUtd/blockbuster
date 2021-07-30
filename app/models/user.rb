class User < ActiveRecord::Base 
    has_secure_password
    # validates 
    validates_uniqueness_of :username, :message=>"This username is already taken. Please try another one"
    has_many :user_movies
    has_many :movies, through: :user_movies 
    has_many :reviews 
    # has_many :reviews, through: :movie_reviews
    

    def vhs_count
        self.movies.count {|movie| movie.format == "VHS"}
    end

    def dvd_count
        self.movies.count {|movie| movie.format == "DVD"}
    end

    def slug
        self.username.gsub("_", "-")
    end

    def self.find_by_slug(slug)
        
        User.all.find {|user| user.slug == slug}
    end

    def movies_rented
        Movie.all.where(user_id: self.id)
    end
end