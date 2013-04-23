class Story < ActiveRecord::Base
	attr_accessible :body, :title, :user_id, :is_pending, :visiable, :pending_reason
	has_many :story_comments, :counter_cache => true, :conditions => { :visiable => true }
	belongs_to :user
	has_attached_file :image
	paginates_per 20

	def check
		self.is_pending = Sensitive.check("#{self.title} #{self.body}")
		self.visiable = !self.is_pending
		if self.is_pending
			self.pending_reason = "含有不合适内容.等待管理员审核."
		end
	end

end
