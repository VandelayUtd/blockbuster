class Movie < ActiveRecord::Base
    has_many :user_movies
    has_many :users, through: :user_movies

    def slug 
        self.title.gsub(" ", "-")
    end

    def self.find_by_slug(slug)
        self.all.find{|movie| movie.slug == slug}
    end

    def self.unique_movies 
        self.all.uniq {|m| m[:title]}
    end

    def vhs_count
        Movie.all.count{|movie| movie.title == self.title && movie.format == "VHS"}
    end

    def dvd_count 
        Movie.all.count{|movie| movie.title == self.title && movie.format == "DVD"}
    end

    
end
