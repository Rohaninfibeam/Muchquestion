class QuestionsController < ApplicationController
  
	def index

	end
	def new
		@ques=Question.new()
		@ques.questiontypes.new
		@ques.options.new
		@questype=Questiontype.all
		render "somethingnew"
	end

	def create
		@question=Question.create(question_params)
		# questype=params[:questionexist]
		# questype.each do |qty|
		# 	que.questiontypes<<Questiontype.find(qty.to_i)
		# end
	end

	private

    def question_params
   	 params.require(:question).permit(:name, :question,questiontype_ids:[],questiontypes_attributes:[:qtype],options_attributes:[:value,:istrue])
  	end

end
