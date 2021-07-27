class Member < ActiveRecord::Base 
    has_secure_password
    has_many :member_movies
    has_many :movie_formats
    has_many :movies, through: :member_movies
    has_many :formats, through: :movie_formats

end