class ExAround
	attr_accessor :Id, :Title, :Context, :Read, :CreatedAt, :Images, :Source, :Summary, :Read, :Like, :Favorite,
				  :CanFavorite, :CanLike, :Image, :Organizer, :OrganizerAvatar, :Contact, :TicketService, :Location

	def self.init_from_around(around, user = nil)
		model = ExAround.new
		model.Id = around.id
		model.Title = around.title
		model.Context = around.context
		model.Source = around.source
		model.Summary = around.summary
		model.Contact = around.contact
		model.TicketService = around.ticket_service
		model.Location = around.location
		model.Read = around.read
		model.CreatedAt = around.created_at
		model.Favorite = around.favorite
		model.Like = around.like
		model.CanFavorite = true
		model.CanLike = true
		model.Image = around.image == nil ? '' : Rails.configuration.host + around.image.url
		model.Organizer = around.admin.display
		model.OrganizerAvatar = around.admin.icon == nil ? '' : Rails.configuration.host + around.admin.icon.url(:medium)
		model.Images = []

		around.around_images.each do |image|
			unless image.nil?
				model.Images << Rails.configuration.host + image.file.url
			end
		end
		
		if user
			model.CanFavorite = around.can_favorite(user)
			model.CanSchedule = around.can_schedule(user)
			model.CanLike = around.can_like(user)
		end

		model
	end
end