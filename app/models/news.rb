# encoding: utf-8
class News < ActiveRecord::Base
	belongs_to :admin, :counter_cache => true
	paginates_per 20
	validates_presence_of :title, :context, :category
	validates_attachment :image, :content_type => { :content_type => ["image/jpeg", "image/jpg"] }, :size => { :in => 0..300.kilobytes }

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
