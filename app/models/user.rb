class User < ActiveRecord::Base 
    has_secure_password
    validates :password_digest, :username, presence: true
    validates :username, uniqueness: true 
    has_many :user_movies
    has_many :movies, through: :user_movies 
    has_many :reviews 
    validates_associated :reviews

    def slug
        self.username.gsub("_", "-")
    end

    def self.find_by_slug(slug)
        
        User.all.find {|user| user.slug == slug}
    end
end