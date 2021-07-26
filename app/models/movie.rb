class Movie < ActiveRecord::Base
    belongs_to :member
    has_many :movie_formats
end
