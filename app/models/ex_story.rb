class ExStory
	attr_accessor :Id, :Title, :Image, :Body, :CommentsCount, :PublishedAt, :UserName, :UserDetails
	def self.init_from_story(story)
		model = ExStory.new
		unless story.nil?
			model.Id = story.id
			model.Title = story.title
			model.Body = story.body
			model.PublishedAt = story.created_at
			model.CommentsCount = story.comments.count
			model.Image = story.image == nil ? '' : Rails.configuration.host + story.image.url
			model.UserName = nil
			model.UserDetails = nil
			unless story.is_anonymous
				model.UserName = story.user.display_name
				model.UserDetails = ExUser.init_from_user(story.user)
			end
		end

		
		model
	end
end