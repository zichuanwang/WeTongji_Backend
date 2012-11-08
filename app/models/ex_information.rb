class ExInformation
	attr_accessor :Id, :Title, :Context, :Read, :CreatedAt, :Category, :Images, :Source, :Summary, :Read, :Like, :Favorite,
				  :CanFavorite, :CanLike

	def self.init_from_information(information, user = nil)
		model = ExInformation.new
		model.Id = information.id
		model.Title = information.title
		model.Context = information.context
		model.Source = information.source
		model.Summary = information.summary
		model.Read = information.read
		model.CreatedAt = information.created_at
		model.Category = information.category
		model.Favorite = information.favorite
		model.Like = information.like
		model.CanFavorite = true
		model.CanLike = true
		
		if user
			model.CanFavorite = information.can_favorite(user)
			model.CanSchedule = information.can_schedule(user)
			model.CanLike = information.can_like(user)
		end

		model
	end
end