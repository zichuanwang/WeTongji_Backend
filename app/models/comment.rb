class Comment < ActiveRecord::Base
  	attr_accessible :body, :is_anonymous, :is_pending, :out_id, :out_model_name, :pending_reason, :user_id, :visiable

  	belongs_to :user
	paginates_per 20

	def check
		self.is_pending = Sensitive.check("#{self.body}")
		self.visiable = !self.is_pending
		if self.is_pending
			self.pending_reason = "含有不合适内容.等待管理员审核."
		end
	end
end
