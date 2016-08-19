class Userquestion < ActiveRecord::Base
	belongs_to :testuser
	has_many :answerusers
	accepts_nested_attributes_for :answerusers
end