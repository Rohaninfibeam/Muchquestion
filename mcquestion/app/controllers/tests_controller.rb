class TestsController < ApplicationController
	def new
		@test=Test.new
		@ques=@test.questions.new
		@ques.questiontypes.new
		@questions=Question.all
		@questype=Questiontype.all
		render "somethingnew"
	end
	def create
		Test.create(testparams)
	end

	private

	def testparams
		params.require(:test).permit(:name,:examtime,:type,questions_attributes:[:name,:question,:options=>[],questiontypes_attributes:[:qtype]])
	end
end
