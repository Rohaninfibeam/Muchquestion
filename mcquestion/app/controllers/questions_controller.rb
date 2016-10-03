class QuestionsController < ApplicationController
  
	def index
		@ques=Question.all
	end
	def new
		@ques=Question.new()
		@ques.questiontypes.new
		@ques.options.new
		@questype=Questiontype.all
		render "somethingnew"
	end

	def create
		@ques=Question.new(question_params)
		if !@ques.save
			render 'somethingnew'
		end
	end

	private

    def question_params
   	 params.require(:question).permit(:name, :question,questiontype_ids:[],questiontypes_attributes:[:qtype],options_attributes:[:value,:istrue])
  	end

end
