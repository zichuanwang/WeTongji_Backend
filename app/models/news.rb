# encoding: utf-8
class News < ActiveRecord::Base
	paginates_per 10
	validates_presence_of :title, :context, :category, :image

	has_attached_file :image, :styles => { :medium => "300x300>", :thumb => "100x100>" }

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
