class ExNotification
	attr_accessor :Id, :Title, :Description, :SourceType, :UnRead, :SourceId, :SourceDetails

	def self.init_from_notification(notification)
		model = ExNotification.new
		model.Id = notification.id
		model.Title = notification.title
		model.Description = notification.description
		model.UnRead = notification.unread
		model.SourceId = notification.out_id
		model.SourceType = notification.out_model_name
		
		case model.SourceType
		when "FriendInvite"
			model.SourceDetails = ExFriendInvite.init_from_friend_invite(FriendInvite.find_by_id(model.SourceId))
		when "ActivityInvite"
			model.SourceDetails = ExActivityInvite.init_from_activity_invite(ActivityInvite.find_by_id(model.SourceId))
		end

		model
	end
end