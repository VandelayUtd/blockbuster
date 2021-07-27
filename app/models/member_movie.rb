class MemberMovie < ActiveRecord::Base 
    belongs_to :movie
    belongs_to :member
end