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
		# raise test_params.inspect
		if !@test.save
			render "somethingnew"
		end
	end

	def edit
		@test=Test.find(params[:id])

	end

	def update
		@test=Test.find(params[:id])
		if @test.update_attributes!(test_params)
			flash[:success]="Test updated successfully"
		else
			puts "not updated successfully"
		end
	end

	def start_test
		test_id=params[:id]
		if session[:started_test]==nil
			session[:started_test]=test_id
		else
			raise "test already started".inspect
		end
		@test=Test.find(test_id)
		@testtime=@test.examtime.strftime("%H:%M:%S")
		user_id=current_user.id
		@testuser=Testuser.where(user_id:user_id,test_id:@test.id,realtestuser_id:nil).first

		if(@testuser.nil?)
			if(@test.type=="Practicetest")
				@test.users<<User.find(user_id)
				@testuser=Testuser.where(user_id:user_id,test_id:@test.id,realtestuser_id:nil).first
			else
				raise "You are not added to the Test".inspect
			end
		end

		if !@testuser.usertests.nil?
			st=@testuser.usertests.last.startedtime
			et=@test.examtime
			if(DateTime.new(st.year,st.month,st.day,(st.hour+et.hour),(st.min+et.min),(st.sec+et.sec))>Time.now)
				if(@test.type="Practicetest")
					@testuser=Testuser.new(:test_id=>test_id,:user_id=>user_id,:realtestuser_id=>@testuser.id)
				else
					raise "you have already submitted the test "
				end
			else


			end
			@testuser=Testuser.new(:test_id=>test_id,:user_id=>user_id,:realtestuser_id=>@testuser.id)
			@userques=@testuser.userquestions.build
			@userques.answerusers.build
		end




















		if ((@test.type=="Practicetest")&&(@testuser.nil?))
			@test.users<<User.find(user_id)
			@testuser=Testuser.where(user_id:user_id,test_id:@test.id,realtestuser_id:nil).first
		end

		if ((@test.type=="Competition")&&(@testuser.nil?))
			raise "You are not added to the Test".inspect
		end

		# if(@testuser.usertests.count==0)

		if((@testuser.usertests.count>0)&&(@test.type=="Competition"))
			raise "You have already submitted the answer for this test".inspect
		end

		@testuser=Testuser.new(:test_id=>test_id,:user_id=>user_id,:realtestuser_id=>@testuser.id)
		@userques=@testuser.userquestions.build
		@userques.answerusers.build
	end

	private

	def test_params
		if params.has_key? :practicetest
    		params[:test] = params.delete :practicetest
  		elsif params.has_key? :competition
  			params[:test] = params.delete :competition
  		end
		params.require(:test).permit(:name,:examtime,:type,question_ids:[],questions_attributes:[:id,:_destroy,:name,:question,questiontype_ids:[],questiontypes_attributes:[:id,:_destroy, :qtype],option_ids:[],options_attributes:[:id, :_destroy, :value,:istrue]])
	end
end
