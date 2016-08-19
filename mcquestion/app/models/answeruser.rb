class Answeruser < ActiveRecord::Base
	belongs_to :option
	belongs_to :userquestion
end
