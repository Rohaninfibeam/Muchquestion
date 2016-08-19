class Test < ActiveRecord::Base
	has_many :testquestions
	has_many :questions, through: :testquestions
	accepts_nested_attributes_for :questions
	has_many :testusers
	has_many :users, through: :testusers
end
