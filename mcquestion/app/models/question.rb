class Question < ActiveRecord::Base
	before_destroy :destroy_assoc
	before_save :orderoption
	validates :name, presence:true
	validates :question, presence:true
	has_many :questiontypeassocs, dependent: :destroy
	has_many :questiontypes, through: :questiontypeassocs
	has_many :testquestions
	has_many :tests, through: :testquestions
	has_many :options
	validates_associated :options
	validates :options, length:{minimum:0, maximum:6}
	accepts_nested_attributes_for :questiontypes, :allow_destroy=>true
	accepts_nested_attributes_for :options, :allow_destroy=>true
	# scope :red, ->{ where(:name=>'asdfg') }

	private

	def orderoption
		orderpresent=true
		self.options.each do |op|
			if op.order.nil?
				orderpresent=false
			end
		end
		if !orderpresent
			optiorder=0
			self.options.each do |op|
				op.order=optiorder
				optiorder=optiorder+1
			end
		end
	end

	def destroy_assoc
		self.questiontypeassocs.destroy_all
		self.options.destroy_all
		self.testquestions.destroy_all
	end

end
