class TestusersController < ApplicationController
	def createuseranswer
		test_id=params[:id]
		user_id=current_user.id
		@testuser=Testuser.where(user_id:user_id,test_id:test_id).first
		@testuser.update(testuserparams)
	end

	private

	def testuserparams
		params.require(:testuser).permit(userquestions_attributes:[:question_id,answerusers_attributes:[:option_id]])
	end
end
