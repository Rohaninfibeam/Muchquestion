class Userquestion < ActiveRecord::Base
	before_destroy :destroy_answeusers
	belongs_to :testuser, ->{where realtestuser_id: nil}
	has_many :answerusers
	accepts_nested_attributes_for :answerusers
	# before_create :checkunique

	# def checkunique
	# 	@userque=Userquestion.where(:question_id=>self.question_id,:testuser_id=>self.testuser_id)
	# 	if(self.testuser.test.type=="Competition")&&(@userque.exists?)
	# 		raise "Error as #{self} already exists".inspect
	# 	end
	# end

	private

	def destroy_answeusers
		self.answerusers.destroy_all
	end
end
