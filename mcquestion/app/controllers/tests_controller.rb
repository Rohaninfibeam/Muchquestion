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
		@test=Test.new(test_params)
		if !@test.save
			render "somethingnew"
		end
	end

	def start_test
		test_id=params[:id]
		@test=Test.find(test_id)
		@testtime=@test.examtime.strftime("%H:%M:%S")
		user_id=current_user.id
		@testuser=Testuser.where(user_id:user_id,test_id:@test.id,realtestuser_id:nil).first

		if ((@test.type=="Practicetest")&&(@testuser.nil?))
			@test.users<<User.find(user_id)
			@testuser=Testuser.where(user_id:user_id,test_id:@test.id,realtestuser_id:nil).first
		end

		if ((@test.type=="Competition")&&(@testuser.nil?))
			raise "You are not added to the Test".inspect
		end

		if((@testuser.usertests.count>0)&&(@test.type=="Competition"))
			raise "You have already submitted the answer for this test".inspect
		end

		@testuser=Testuser.new(:test_id=>test_id,:user_id=>user_id,:realtestuser_id=>@testuser.id)
		@userques=@testuser.userquestions.build
		@userques.answerusers.build
	end

	private

	def test_params
		params.require(:test).permit(:name,:examtime,:type,question_ids:[],questions_attributes:[:name,:question,questiontype_ids:[],questiontypes_attributes:[:qtype],options_attributes:[:value,:istrue]])
	end
end
