class TestsController < ApplicationController

	def index
		@test=Test.all
	end

	def new
		@test=Test.new
		@que=@test.testquestions.new
		@ques=@que.build_question
		@ques.options.new
		@ques.questiontypes.new
		@questions=Question.all
		@questype=Questiontype.all
		render "somethingnew"
	end

	def create

		# raise test_params_new.inspect
		@test=Test.new(test_params)
		# raise test_params.inspect
		if !@test.save
			render "somethingnew"
		end
	end

	def edit
		@test=Test.find(params[:id])

	end

  def testupload
		@testfile=TestUpload.new
	end

	def uploadfile
		file=params[:filename]
		name=file.original_filename
		current_time=Time.now.strftime("%d_%m_%Y_%H_%M_%S")
		newname=name+current_time
	  root_path=FileUtils.pwd
		path=File.join(root_path,"file_upload")
		FileUtils.mkdir_p(path) if(!File.directory?(path))
		filename=File.join(path,newname)
		File.open(filename, "wb"){|f| f.write(file.read)}
		@testupload=TestUpload.new(:filename=>filename,:path=>path,:fname=>newname,:external_file_name=>name)
		@testupload.save
	end

	def update
		@test=Test.find(params[:id])
		# questionorder=1
		# test_params_new = Marshal.load(Marshal.dump(test_params))
		# test_params_new["testquestions_attributes"].each do |key,val|
		# 	if(val["_destroy"]=="0")
		# 		val.merge!("order"=> questionorder)
		# 		# raise val.inspect
		# 		questionorder=questionorder+1
		# 	end
		# 	optionorder=1
		# 	val["question_attributes"]["options_attributes"].each do |k,v|
		# 			if(v["_destroy"]=="0")
		# 				v.merge!("order"=>optionorder)
		# 				optionorder=optionorder+1
		# 			end
		# 	end
		# end

		# raise test_params_new.inspect

		if @test.update_attributes!(test_params)
			flash[:success]="Test updated successfully"
		else
			puts "not updated successfully"
		end
	end

	def start_test
		test_id=params[:id]
		# if session[:started_test]==nil
		# 	session[:started_test]=test_id
		# else
		# 	raise "test already started".inspect
		# end
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
		if params.has_key? :practicetest
    		params[:test] = params.delete :practicetest
  		elsif params.has_key? :competition
  			params[:test] = params.delete :competition
  		end
		params.require(:test).permit(:name,:examtime,:type,question_ids:[],testquestions_attributes:[:id,:_destroy,:order,question_attributes:[:id,:name,:question,questiontype_ids:[],questiontypes_attributes:[:id,:_destroy, :qtype],option_ids:[],options_attributes:[:id, :_destroy,:order, :value,:istrue]]])
	end
end
