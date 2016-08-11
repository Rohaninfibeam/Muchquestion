class QuestionsController < ApplicationController
	def index
		
	end
	def new
		@ques=Question.new()
		@ques.questiontypes.new
		@questype=Questiontype.all
		render "somethingnew"
	end

	def create
		que=Question.create(question_params)
		questype=params[:questionexist]
		questype.each do |qty|
			que.questiontypes<<Questiontype.find(qty.to_i)
		end
	end

	private

    def question_params
   	 params.require(:question).permit(:name, :question, :options=>[],questiontypes_attributes:[:qtype])
  	end
 
end
