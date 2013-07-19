class ExInformation
	attr_accessor :Id, :Title, :Context, :Read, :CreatedAt, :Category, :Images, :Source, :Summary, :Read, :Like, :AccountId,
				  :CanLike, :Image, :Organizer, :OrganizerAvatar, :Contact, :Addition, :Location, :HasTicket, :TicketService,
				  :AccountDetails

	def self.init_from_information(information, user = nil)
		model = ExInformation.new
		unless information.nil?
			model.Id = information.id
			model.Title = information.title
			model.Context = information.context

			unless information.information_external.nil?
				model.Source = information.information_external.source
				model.Summary = information.information_external.summary
				model.Contact = information.information_external.contact
				model.Location = information.information_external.location
				model.HasTicket = information.information_external.has_ticket
				model.TicketService = information.information_external.ticket_service	
			end

			model.Read = information.read
			model.CreatedAt = information.created_at
			model.Category = information.category
			model.Like = UserLike.get_count("Information", model.Id)
			model.AccountId = information.admin.id
			model.AccountDetails = ExAccount.init_from_account(information.admin, user)
			model.CanLike = user.nil? ? false : UserLike.can?("Information", information.id, user.id)
			model.Organizer = information.admin.display
			model.OrganizerAvatar = !information.admin.icon.exists? ? '' : Rails.configuration.host + information.admin.icon.url(:medium)
			model.Images = []

			information.information_images.each do |image|
				if !image.nil? && image.file.exists?
					model.Images << Rails.configuration.host + image.file.url
				end
			end
			
		end

		model
	end
end
