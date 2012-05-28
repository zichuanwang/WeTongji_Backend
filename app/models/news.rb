class News < ActiveRecord::Base
	paginates_per 20
	validates_presence_of :title, :context, :category, :image

	has_attached_file :image, :styles => { :medium => "300x300>", :thumb => "100x100>" }

	before_create :init_model

	private
	def init_model
		self.read = 1
	end
end
