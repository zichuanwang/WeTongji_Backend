class ExComment
	attr_accessor :Id, :Body, :PublishedAt, :UserName
	def self.init_from_comment(comment)
		model = ExComment.new
		model.Id = comment.id
		model.Body = comment.body
		model.PublishedAt = comment.created_at
		unless comment.is_anonymous
			model.UserName = comment.user.display_name
		end
		
		model
	end
end