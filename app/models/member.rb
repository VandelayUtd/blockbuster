class Member < ActiveRecord::Base 
    has_secure_password
    has_many :member_movies    
    has_many :movies, through: :member_movies

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
        
        Member.all.find {|member| member.slug == slug}
    end

end