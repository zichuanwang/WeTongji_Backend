class ExActivity
	attr_accessor :Id, :Begin, :End, :Title, :Location, :Image, :Favorite, :Organizer, 
				  :OrganizerAvatar, :Channel_Id, :Status, :Description, :Like, :Schedule, 
				  :CanFavorite, :CanLike, :CanSchedule, :CreatedAt, :AccountId, :AccountDetails,
				  :FriendsCount

	def self.init_from_activity(activity, user = nil)
		model = ExActivity.new
		unless activity.nil?
			model.Id = activity.id
			model.Image = !activity.image.exists? ? '' : Rails.configuration.host + activity.image.url
			model.Begin = activity.begin
			model.End = activity.end
			model.Location = activity.location
			model.Title = activity.title
			model.Favorite = activity.favorite
			model.Organizer = activity.admin.display
			model.OrganizerAvatar = !activity.admin.icon.exists? ? '' : Rails.configuration.host + activity.admin.icon.url(:medium)
			model.Channel_Id = activity.channel.id
			model.Status = activity.status
			model.Description = activity.description#.gsub(/https?:\/\/[\S]+/,' \0 ').gsub(/[^@\s]+@(?:[-a-z0-9]+\.)+[a-z]{2,}/, ' \0 ').gsub(/[0-9|\-|\(|\)|\#|\+]{7,}/, ' \0 ')
			model.Like = UserLike.get_count("Activity", model.Id)
			model.Schedule = activity.schedule
			model.CanFavorite = true
			model.CanSchedule = true
			model.CanLike = true
			model.CreatedAt = activity.created_at
			model.AccountId = activity.admin.id
			model.AccountDetails = ExAccount.init_from_account(activity.admin, user)
			model.FriendsCount = 0
			
			if user
				model.CanFavorite = activity.can_favorite(user)
				model.CanSchedule = activity.can_schedule(user)
				model.CanLike = activity.can_like(user)
			end
		end
		
		model
	end
end