class TestsController < ApplicationController
	def new
		@test=Test.new
		@ques=@test.questions.new
		@ques.questiontypes.new
		@ques.options.new
		@questions=Question.all
		@questype=Questiontype.all
		render "somethingnew"
	end
	def create
		Test.create(testparams)
	end
	def start_test
		test_id=params[:id]
		@test=Test.find(test_id)
		user_id=current_user.id
		@testuser=Testuser.where(user_id:user_id,test_id:@test.id).first
		@userques=@testuser.userquestions.new
		@userques.answerusers.new
	end

	private

	def testparams
		params.require(:test).permit(:name,:examtime,:type,questions_attributes:[:name,:question,questiontypes_attributes:[:qtype],options_attributes:[:value,:istrue]])
	end
end
