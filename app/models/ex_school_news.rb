class ExSchoolNews
	attr_accessor :Id, :Title, :Context, :Read, :CreatedAt, :Images, :Source, :Summary, :Read, :Like, :Favorite,
				  :CanFavorite, :CanLike, :Organizer, :OrganizerAvatar, :AccountId, :AccountDetails

	def self.init_from_school_news(school_news, user = nil)
		model = ExSchoolNews.new
		model.Id = school_news.id
		model.Title = school_news.title
		model.Context = school_news.context.gsub(/https?:\/\/[\S]+/,' \0 ').gsub(/[^@\s]+@(?:[-a-z0-9]+\.)+[a-z]{2,}/, ' \0 ').gsub(/[0-9|\-|\(|\)|\#|\+]{7,}/, ' \0 ')
		model.Source = school_news.source
		model.Summary = school_news.summary
		model.Read = school_news.read
		model.CreatedAt = school_news.created_at
		model.Favorite = school_news.favorite
		model.Like = UserLike.get_count("Information", model.Id)
		model.CanFavorite = true
		model.CanLike = true
		model.Organizer = school_news.admin.display
		model.OrganizerAvatar = !school_news.admin.icon.exists? ? '' : Rails.configuration.host + school_news.admin.icon.url(:medium)
		model.Images = []
		model.AccountId = school_news.admin.id
		model.AccountDetails = ExAccount.init_from_account(school_news.admin, user)
		school_news.school_news_images.each do |image|
			if !image.nil? && image.file.exists?
				model.Images << Rails.configuration.host + image.file.url
			end
		end
		
		if user
			model.CanFavorite = school_news.can_favorite(user)
			model.CanLike = school_news.can_like(user)
		end

		model
	end
end
