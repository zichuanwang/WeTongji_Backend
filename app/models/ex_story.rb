class ExStory
	attr_accessor :Id, :Title, :Image, :Body, :CommentsCount, :PublishedAt, :UserName
	def self.init_from_story(story)
		model = ExStory.new
		model.Id = story.id
		model.Title = story.title
		model.Body = story.body
		model.PublishedAt = story.created_at
		model.CommentsCount = story.story_comments.count
		model.Image = story.image == nil ? '' : Rails.configuration.host + story.image.url
		unless story.is_anonymous
			model.UserName = story.user.display_name
		end
		
		model
	end
end