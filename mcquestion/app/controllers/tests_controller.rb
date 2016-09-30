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
		@test=Test.create(test_params)
	end

	def start_test
		test_id=params[:id]
		@test=Test.find(test_id)
		@testtime=@test.examtime.strftime("%H:%M:%S")
		user_id=current_user.id
		@testuser=Testuser.where(user_id:user_id,test_id:@test.id,realtestuser_id:nil).first

		if(@testuser.nil?)
			if(@test.type=="Practicetest")
				@test.users<<User.find(user_id)
				@testuser=Testuser.where(user_id:user_id,test_id:@test.id,realtestuser_id:nil).first
			else
				raise "You are not added to test"
			end
		end

		if(@testuser.usertests.empty?)
			@testuser=@testuser.usertests.new(user_id:user_id,test_id:@test.id,starttime:Time.now)
			@testuser.save
		else
			@lust=@testuser.usertests.last.starttime
			@tm=@test.examtime
			@totdate=DateTime.new(@lust.year,@lust.month,@lust.day,(@lust.hour+@tm.hour),(@lust.min+@tm.min),(@lust.sec+@tm.sec),@lust.zone)
			# raise @totdate.inspect

			if(@totdate<=Time.current)
				if(@test.type="Practicetest")
					@testuser=@testuser.usertests.new(user_id:user_id,test_id:@test.id,starttime:Time.now)
					@testuser.save
				else
					raise "You have already submitted the answer"
				end
				# raise "safddaefwev".inspect
			else
				@testuser=@testuser.usertests.last
				total_seconds=@totdate.to_time-Time.current.to_time
				   # raise total_seconds.inspect
				@testtime=Time.at(total_seconds).utc.strftime("%H:%M:%S")
			end
		end






		# if ((@test.type=="Practicetest")&&(@testuser.nil?))
		# 	@test.users<<User.find(user_id)
		# 	@testuser=Testuser.where(user_id:user_id,test_id:@test.id,realtestuser_id:nil).first
		# end

		# if ((@test.type=="Competition")&&(@testuser.nil?))
		# 	raise "You are not added to the Test".inspect
		# end

		# if((@testuser.usertests.count>0)&&(@test.type=="Competition"))
		# 	raise "You have already submitted the answer for this test".inspect
		# end

		# @testuser=Testuser.new(:test_id=>test_id,:user_id=>user_id,:realtestuser_id=>@testuser.id)
		@userques=@testuser.userquestions.build
		@userques.answerusers.build
	end

	private

	def test_params
		params.require(:test).permit(:name,:examtime,:type,question_ids:[],questions_attributes:[:name,:question,questiontype_ids:[],questiontypes_attributes:[:qtype],options_attributes:[:value,:istrue]])
	end
end
