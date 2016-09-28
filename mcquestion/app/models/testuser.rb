class Testuser < ActiveRecord::Base
	belongs_to :user
	belongs_to :test
	has_many :userquestions
	has_many :usertests, class_name: "Testuser", foreign_key: "realtestuser_id"
	belongs_to :realtestuser, class_name: "Testuser"
	accepts_nested_attributes_for :userquestions
end
