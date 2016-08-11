class Questiontypeassoc < ActiveRecord::Base
	belongs_to :question
	belongs_to :questiontype
end
