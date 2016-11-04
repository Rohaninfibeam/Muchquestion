class Testuser < ActiveRecord::Base
	before_destroy :destroy_userquestions
	# before_save :submit_answer
	belongs_to :user
	belongs_to :test
	has_many :userquestions
	has_many :usertests, class_name: "Testuser", foreign_key: "realtestuser_id"
	belongs_to :realtestuser, class_name: "Testuser"
	accepts_nested_attributes_for :userquestions

	def submit_answer
		self.submitted=true
	end

	private

	def destroy_userquestions
		self.userquestions.destroy_all
		# self.usertests.destroy_all
	end
end
