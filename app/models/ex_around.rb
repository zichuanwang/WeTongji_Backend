class ExAround
	attr_accessor :Id, :Title, :Context, :Read, :CreatedAt, :Images, :Source, :Summary, :Read, :Like, :Favorite,
				  :CanFavorite, :CanLike, :Image, :Organizer, :OrganizerAvatar, :Contact, :TicketService, :Location, 
				  :HasTicket, :AccountId, :AccountDetails

	def self.init_from_around(around, user = nil)
		model = ExAround.new
		model.Id = around.id
		model.Title = around.title
		model.Context = around.context.gsub(/https?:\/\/[\S]+/,' \0 ').gsub(/[^@\s]+@(?:[-a-z0-9]+\.)+[a-z]{2,}/, ' \0 ').gsub(/[0-9|\-|\(|\)|\#|\+]{7,}/, ' \0 ')
		model.Source = around.source
		model.Summary = around.summary
		model.Contact = around.contact
		model.TicketService = around.ticket_service
		model.Location = around.location
		model.Read = around.read
		model.CreatedAt = around.created_at
		model.Favorite = around.favorite
		model.Like = UserLike.get_count("Information", model.Id)
		model.HasTicket = around.has_ticket
		model.CanFavorite = true
		model.CanLike = true
		#model.Image = !around.image.exists? ? '' : Rails.configuration.host + around.image.url
		model.Organizer = around.admin.display
		model.OrganizerAvatar = !around.admin.icon.exists? ? '' : Rails.configuration.host + around.admin.icon.url(:medium)
		model.Images = []
		model.AccountId = around.admin.id
		model.AccountDetails = ExAccount.init_from_account(around.admin, user)
		around.information_images.each do |image|
			unless !image.nil? && image.file.exists?
				if model.Image.nil?
					model.Image = Rails.configuration.host + image.file.url
				else
					model.Images << Rails.configuration.host + image.file.url
				end
			end
		end
		
		if user
			model.CanFavorite = around.can_favorite(user)
			model.CanLike = around.can_like(user)
		end

		model
	end
end
