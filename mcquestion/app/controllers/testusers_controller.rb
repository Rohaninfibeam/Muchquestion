class TestusersController < ApplicationController
	def createuseranswer
		# test_id=params[:id]
		user_id=current_user.id
		# @testuser=Testuser.where(user_id:user_id,test_id:test_id).first
		test_params_new = Marshal.load(Marshal.dump(testuser_params))
		raise test_params_new[:test_id].inspect
		@test=Test.find(test_params_new[:test_id])
		test_exist,error=@test.validate_test(user_id)
		if test_exist
			test_params_new[:user_id]=user_id
			test_params_new[:realtestuser_id]=user_id
			@testuser=Testuser.create(testuser_params)
		else
			raise "dsafasdf"
		end
	end

	def update
		@testuser=Testuser.find(params[:id])
		@testuser=@testuser.update(testuser_params)
	end

	private

	def testuser_params
		params.require(:testuser).permit(userquestions_attributes:[:id,:question_id,answerusers_attributes:[:id,:option_id,:option_name]])
	end
end
