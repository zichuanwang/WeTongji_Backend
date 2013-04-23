class StoryComment < ActiveRecord::Base
	attr_accessible :body, :user_id, :is_pending, :visiable, :pending_reason
	belongs_to :user

	def check
		self.is_pending = Sensitive.check("#{self.body}")
		self.visiable = !self.is_pending
		if self.is_pending
			self.pending_reason = "含有不合适内容.等待管理员审核."
		end
	end
end
