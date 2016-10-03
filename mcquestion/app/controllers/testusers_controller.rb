class TestusersController < ApplicationController
	def createuseranswer
		# test_id=params[:id]
		# user_id=current_user.id
		# @testuser=Testuser.where(user_id:user_id,test_id:test_id).first
		@testuser=Testuser.create(testuser_params)
	end

	def update
		@testuser=Testuser.find(params[:id])
		@testuser=@testuser.update(testuser_params)
	end
	
	private

	def testuser_params
		params.require(:testuser).permit(:test_id,:user_id,:realtestuser_id,userquestions_attributes:[:question_id,answerusers_attributes:[:option_id]])
	end
end
