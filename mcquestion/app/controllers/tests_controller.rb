class TestsController < ApplicationController
	
	def index
		@test=Test.all
	end

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
		@testuser=Testuser.where(user_id:user_id,test_id:@test.id,realtestuser_id:nil).first
		if((@testuser.usertests.count>0)&&(@test.type=="Competition"))
			raise "You have already submitted the answer for this test".inspect
		end
		@testuser=Testuser.new(:test_id=>test_id,:user_id=>user_id,:realtestuser_id=>@testuser.id)
		@userques=@testuser.userquestions.build
		@userques.answerusers.build
	end

	private

	def testparams
		params.require(:test).permit(:name,:examtime,:type,question_ids:[],questions_attributes:[:name,:question,questiontype_ids:[],questiontypes_attributes:[:qtype],options_attributes:[:value,:istrue]])
	end
end
