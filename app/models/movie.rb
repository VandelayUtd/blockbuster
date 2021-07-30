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

    def out_of_stock?
        self.inventory == 0 
    end

    def self.instock 
        Movie.all.select{|movie| movie.inventory > 0}
    end

    # def self.rented
    #     Movie.all.where(user_id: [1..99])
    # end

    def self.list
        Movie.instock.uniq{|movie| movie.title}
    end


    def vhs_count 
        Movie.instock.count {|movie| movie.format == "VHS" && movie.title == self.title}
    end


    def dvd_count 
        Movie.instock.count {|movie| movie.format == "DVD" && movie.title == self.title}
    end

end
