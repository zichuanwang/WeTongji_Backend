class ExInformation
	attr_accessor :Id, :Title, :Context, :Read, :CreatedAt, :Category, :Images, :Source, :Summary, :Read, :Like, :Favorite,
				  :CanFavorite, :CanLike, :Image, :Organizer, :OrganizerAvatar, :Contact, :Addition, :Location

	def self.init_from_information(information, user = nil)
		model = ExInformation.new
		model.Id = information.id
		model.Title = information.title
		model.Context = information.context
		model.Source = information.source
		model.Summary = information.summary
		model.Contact = information.contact
		model.Addition = information.addition
		model.Location = information.location
		model.Read = information.read
		model.CreatedAt = information.created_at
		model.Category = information.category
		model.Favorite = information.favorite
		model.Like = information.like
		model.CanFavorite = true
		model.CanLike = true
		model.Image = information.image == nil ? '' : Rails.configuration.host + information.image.url
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
			model.CanSchedule = information.can_schedule(user)
			model.CanLike = information.can_like(user)
		end

		model
	end
end