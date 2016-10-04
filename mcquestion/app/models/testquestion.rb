class Testquestion < ActiveRecord::Base
  default_scope { order(:order) }
	belongs_to :test
	belongs_to :question
	accepts_nested_attributes_for :question
end
