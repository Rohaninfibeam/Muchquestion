class Questiontype < ActiveRecord::Base
	has_many :questiontypeassocs
	has_many :questions, :through=>:questiontypeassocs 
	serialize :thearray,Array
end
