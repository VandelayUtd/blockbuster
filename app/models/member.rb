class Member < ActiveRecord::Base 
    has_many :movies
    has_many :formats, through: :movie_formats

end