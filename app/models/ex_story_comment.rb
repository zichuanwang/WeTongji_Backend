class ExStoryComment
	attr_accessor :Id, :Body, :PublishedAt
	def self.init_from_story_comment(comment)
		model = ExStoryComment.new
		model.Id = comment.id
		model.Body = comment.body
		model.PublishedAt = comment.created_at
		
		model
	end
end