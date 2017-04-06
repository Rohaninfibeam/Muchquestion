class Test < ActiveRecord::Base
	before_destroy :destroy_assoc
	before_save :make_ordering
	validates :name,:examtime, presence:true
	has_many :testquestions
	has_many :questions, through: :testquestions
	validates_associated :questions
	accepts_nested_attributes_for :testquestions
	# validates :questions, length:{minimum:1, maximum:6}
	# accepts_nested_attributes_for :questions, :allow_destroy=>true
	# , :reject_if => lambda { |a| a.blank? }
	has_many :testusers, -> {where realtestuser_id: nil}
	has_many :users, through: :testusers

	def validate_test(user_id)
		if(self.type=="Competition")
			@testuser=Testuser.where(user_id:user_id,test_id:self.id,realtestuser_id:nil).first
			if(@testuser.nil?)
				return false, "User is not added for the test"
			elsif @testuser.usertests.empty?
				return true,"Test can be created"
			else
				@lust=@testuser.usertests.last.starttime
				@tm=self.examtime
				@totdate=DateTime.new(@lust.year,@lust.month,@lust.day,(@lust.hour+@tm.hour),(@lust.min+@tm.min),(@lust.sec+@tm.sec),@lust.zone)
				if(@totdate<=Time.now)
					return false, "Test is already finished"
				elsif @testuser.usertests.last.submitted
					return false, "You have already submitted"
				else
					return true, "Test can be created"
				end
			end
		end
	end

	def find_result(user_id)
		tu=self.testusers.where("user_id"=>user_id).first
		pp tu.usertests.map{|ut| {ut.id=>ut.userquestions.select{|uq| uq.answerusers.select{|au| au.option_id!=Option.find(au.option_name).istrue}.count==0}.count}}
	end

	private

	def make_ordering
		orderpresent=true
		self.testquestions.each do |tq|
			if tq.order.nil?
				orderpresent=false
			end
		end
		if !orderpresent
			quesorder=0
			self.testquestions.each do |tq|
				tq.order=quesorder
				quesorder=quesorder+1
			end
		end
	end

	def destroy_assoc
		self.testquestions.destroy_all
		self.testusers.destroy_all
	end
	
end
