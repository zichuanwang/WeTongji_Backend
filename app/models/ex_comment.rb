class ExComment
	attr_accessor :Id, :Body, :PublishedAt, :UserName, :UserDetails
	def self.init_from_comment(comment)
		model = ExComment.new
		model.Id = comment.id
		model.Body = comment.body
		model.PublishedAt = comment.created_at
		model.UserName = nil
		model.UserDetails = nil
		unless comment.is_anonymous
			model.UserName = comment.user.display_name
			model.UserDetails = ExUser.init_from_user(comment.user)
		end
		
		model
	end
end