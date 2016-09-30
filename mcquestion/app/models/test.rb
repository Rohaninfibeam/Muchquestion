class Test < ActiveRecord::Base
	validates :name,:examtime, presence:true
	has_many :testquestions
	has_many :questions, through: :testquestions
	validates_associated :questions
	# validates :questions, length:{minimum:1, maximum:6}
	accepts_nested_attributes_for :questions, :allow_destroy=>true
	# , :reject_if => lambda { |a| a.blank? }
	has_many :testusers, -> {where realtestuser_id: nil}
	has_many :users, through: :testusers
end
