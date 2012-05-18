class ExActivity
	attr_accessor :Id, :Begin, :End, :Title, :Location, :Image, :Favorite, :Organizer, :OrganizerAvatar, :Channel_Id, :SubOrganizer, :Status, :Description, :Like, :Schedule, :CanFavorite, :CanLike, :CanSchedule

	def self.init_from_activity(activity, user = nil)
		model = ExActivity.new
		model.Id = activity.id
		model.Image = activity.image == nil ? '' : Rails.configuration.host + activity.image.url
		model.OrganizerAvatar = activity.organizer.icon == nil ? '' : Rails.configuration.host + activity.organizer.icon.url
		model.Begin = activity.begin
		model.End = activity.end
		model.Location = activity.location
		model.Title = activity.title
		model.Favorite = activity.favorite
		model.Organizer = activity.organizer.name
		model.SubOrganizer = activity.sub_organizer.name
		model.Channel_Id = activity.channel.id
		model.Status = activity.status
		model.Description = activity.description
		model.Like = activity.like
		model.Schedule = activity.schedule
		model.CanFavorite = true
		model.CanSchedule = true
		model.CanLike = true
		
		if user
			model.CanFavorite = activity.can_favorite(user)
			model.CanSchedule = activity.can_schedule(user)
			model.CanLike = activity.can_like(user)
		end

		model
	end
end