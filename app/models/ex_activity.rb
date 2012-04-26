class ExActivity
	attr_accessor :Id, :Begin, :End, :Title, :Location, :Follow, :Organizer, :SubOrganizer, :Status, :Description, :Like, :Hot, :CanFollow, :CanLike, :CanHot

	def self.init_from_activity(activity)
		model = ExActivity.new
		model.Id = activity.id
		model.Begin = activity.begin
		model.End = activity.end
		model.Location = activity.location
		model.Title = activity.title
		model.Follow = activity.follow
		model.Organizer = activity.organizer.name
		model.SubOrganizer = activity.sub_organizer.name
		model.Status = activity.status
		model.Description = activity.description
		model.Like = activity.like
		model.Hot = activity.hot
		model.CanFollow = true
		model.CanHot = true
		model.CanLike = true
		model
	end
end