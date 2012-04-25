class Activity < ActiveRecord::Base
	belongs_to :channel

	before_create :init_model

	private
	def init_model
		self.follow = 0
	end
end
