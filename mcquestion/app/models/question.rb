class Question < ActiveRecord::Base
	validates :name, presence:true
	validates :question, presence:true
	has_many :questiontypeassocs, dependent: :destroy
	has_many :questiontypes, through: :questiontypeassocs
	has_many :testquestions
	has_many :tests, through: :testquestions
	has_many :options
	validates_associated :options
	validates :options, length:{minimum:3, maximum:6}
	accepts_nested_attributes_for :questiontypes
	accepts_nested_attributes_for :options
	# scope :red, ->{ where(:name=>'asdfg') }
end
