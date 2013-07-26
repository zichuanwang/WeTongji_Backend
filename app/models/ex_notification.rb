class ExNotification
	attr_accessor :Id, :Title, :Description, :SourceType, :UnRead, :SourceId, :SourceDetails

	def self.init_from_notification(notification, user = nil)
		model = ExNotification.new
		model.Id = notification.id
		model.Title = notification.title
		model.Description = notification.description
		model.UnRead = notification.unread
		model.SourceId = notification.out_id
		model.SourceType = notification.out_model_name
		
		case model.SourceType
		when "FriendInvite"
			model.SourceDetails = ExFriendInvite.init_from_friend_invite(FriendInvite.find_by_id(model.SourceId), user)
		when "ActivityInvite"
			model.SourceDetails = ExActivityInvite.init_from_activity_invite(ActivityInvite.find_by_id(model.SourceId), user)
		when "CourseInvite"
			model.SourceDetails = ExCourseInvite.init_from_course_invite(CourseInvite.find_by_id(model.SourceId), user)
		end

		model
	end
end