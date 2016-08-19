class TestusersController < ApplicationController
	def createuseranswer
		@testuser.userquestions.new
	end

	private

	def testuserparams
		params.require(:testuser).permit(:user_id,:test_id,userquestions_attributes:[:question_id,answeruser_attributes:[:option_id]])
	end
end
