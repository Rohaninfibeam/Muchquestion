class Testquestion < ActiveRecord::Base
	belongs_to :test
	belongs_to :question
	accepts_nested_attributes_for :question
end
