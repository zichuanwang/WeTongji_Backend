class ExInformation
	attr_accessor :Id, :Title, :Context, :Read, :CreatedAt, :Category, :Images, :Source, :Summary, :Read, :Like, :Favorite,
				  :CanFavorite, :CanLike, :Image, :Organizer, :OrganizerAvatar, :Contact, :Addition, :Location, :HasTicket, :TicketService

	def self.init_from_information(information, user = nil)
		model = ExInformation.new
		model.Id = information.id
		model.Title = information.title
		model.Context = information.context
		model.Source = information.information_external.source
		model.Summary = information.information_external.summary
		model.Contact = information.information_external.contact
		model.Location = information.information_external.location
		model.HasTicket = information.information_external.has_ticket
		model.TicketService = information.information_external.ticket_service
		model.Read = information.read
		model.CreatedAt = information.created_at
		model.Category = information.category
		model.Favorite = information.favorite
		model.Like = information.like
		model.CanFavorite = true
		model.CanLike = true
		model.Organizer = information.admin.display
		model.OrganizerAvatar = information.admin.icon == nil ? '' : Rails.configuration.host + information.admin.icon.url(:medium)
		model.Images = []

		information.information_images.each do |image|
			unless image.nil?
				model.Images << Rails.configuration.host + image.file.url
			end
		end
		
		if user
			model.CanFavorite = information.can_favorite(user)
			model.CanLike = information.can_like(user)
		end

		model
	end
end