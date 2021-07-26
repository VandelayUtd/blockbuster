class MovieFormat < ActiveRecord::Base
    belongs_to :format
    belongs_to :movie
end