class News < ActiveRecord::Base
	paginates_per 20
	validates_presence_of :title, :context, :category

	before_create :init_model

	private
	def init_model
		self.read = 0
	end
end
