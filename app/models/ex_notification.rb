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
		model
	end
end