class ExActivity
	attr_accessor :Id, :Begin, :End, :Title, :Location, :Favorite, :Organizer, :Channel_Id, :SubOrganizer, :Status, :Description, :Like, :Schedule, :CanFavorite, :CanLike, :CanSchedule

	def self.init_from_activity(activity, uid = nil)
		model = ExActivity.new
		model.Id = activity.id
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
		if uid
			user = User.find_by_uid(uid)
			if user
				
			end
		end
		model
	end
end