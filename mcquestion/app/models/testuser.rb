class Testuser < ActiveRecord::Base
	belongs_to :user
	belongs_to :test
	has_many :userquestions

	accepts_nested_attributes_for :userquestions
end
