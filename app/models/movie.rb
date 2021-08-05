class Movie < ActiveRecord::Base
    has_many :user_movies
    has_many :users, through: :user_movies
    has_many :reviews
    def slug 
        self.title.gsub(" ", "-")
    end

    def self.find_by_slug(slug)
        Movie.all.find{|movie| movie.slug == slug}
    end

    def self.list
        Movie.all.uniq{|movie| movie.title}
    end
end
