class ExClubNews
	attr_accessor :Id, :Title, :Context, :Read, :CreatedAt, :Images, :Read, :Like, :Favorite,
				  :CanFavorite, :CanLike, :Organizer, :OrganizerAvatar

	def self.init_from_club_news(club_news, user = nil)
		model = ExClubNews.new
		model.Id = club_news.id
		model.Title = club_news.title
		model.Context = club_news.context
		model.Read = club_news.read
		model.CreatedAt = club_news.created_at
		model.Favorite = club_news.favorite
		model.Like = club_news.like
		model.CanFavorite = true
		model.CanLike = true
		model.Organizer = club_news.admin.display
		model.OrganizerAvatar = club_news.admin.icon == nil ? '' : Rails.configuration.host + club_news.admin.icon.url(:medium)
		model.Images = []

		club_news.club_news_images.each do |image|
			unless image.nil?
				model.Images << Rails.configuration.host + image.file.url
			end
		end
		
		if user
			model.CanFavorite = club_news.can_favorite(user)
			model.CanSchedule = club_news.can_schedule(user)
			model.CanLike = club_news.can_like(user)
		end

		model
	end
end