class Option < ActiveRecord::Base
	default_scope { order(:order) }
	belongs_to :question
	validates :value, presence: true
end
