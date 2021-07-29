class Movie < ActiveRecord::Base
    belongs_to :user
    has_many :reviews
    def slug 
        self.title.gsub(" ", "-")
    end

    def self.find_by_slug(slug)
        self.all.find{|movie| movie.slug == slug}
    end

    def self.instock 
        Movie.all.where(user_id: nil)
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
