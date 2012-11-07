# encoding: utf-8
class Information < ActiveRecord::Base
	belongs_to :admin, :counter_cache => true
	has_many :information_images
	paginates_per 20
	validates_presence_of :title, :context, :category

	before_create :init_model

	def check
		self.is_pending = Sensitive.check("#{self.title} #{self.context}")
		self.visiable = !self.is_pending
		if self.is_pending
			self.pending_reason = "含有不合适内容.等待管理员审核."
		end
	end

	private
	def init_model
		self.read = 1
	end
end
