class ExLike
	attr_accessor :Id, :Model, :CreatedAt, :ModelDetails

	def self.init_from_like(like, user)
		model = ExLike.new
		model.Id = like.out_id
		model.Model = like.out_model_name
		case model.Model
		when "Activity"
			model.ModelDetails = ExActivity.init_from_activity(Activity.find_by_id(model.Id), user)
		when "News"
			model.ModelDetails = ExNews.init_from_news(News.find_by_id(model.Id))
		when "Story"
			model.ModelDetails = ExStory.init_from_story(Story.find_by_id(model.Id))
		when "Account"
			model.ModelDetails = ExAccount.init_from_account(Story.find_by_id(model.Id), user)
		when "User"
			model.ModelDetails = ExUser.init_from_user(User.find_by_uid(model.Id), user)
		when "Person"
			model.ModelDetails = ExUser.init_from_person(Person.find_by_id(model.Id), user)
		end
		model.CreatedAt = like.created_at
		model
	end
end