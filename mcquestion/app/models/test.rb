class Test < ActiveRecord::Base
	has_many :testquestions
	has_many :questions, through: :testquestions
	accepts_nested_attributes_for :questions
end
