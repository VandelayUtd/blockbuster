class Movie < ActiveRecord::Base
    has_many :member_movies
    has_many :movie_formats
    has_many :members, through: :member_movies
    has_many :formats, through: :movie_formats
end
