class Question < ActiveRecord::Base
	has_many :questiontypeassocs, dependent: :destroy
	has_many :questiontypes, through: :questiontypeassocs
	has_many :testquestions
	has_many :tests, through: :testquestions
	serialize :options ,Array
	accepts_nested_attributes_for :questiontypes
end
