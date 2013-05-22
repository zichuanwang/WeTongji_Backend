class ExForStaff
	attr_accessor :Id, :Title, :Context, :Read, :CreatedAt, :Images, :Source, :Summary, :Read, :Like, :Favorite,
				  :CanFavorite, :CanLike, :Organizer, :OrganizerAvatar, :AccountId

	def self.init_from_for_staff(for_staff, user = nil)
		model = ExForStaff.new
		model.Id = for_staff.id
		model.Title = for_staff.title
		model.Context = for_staff.context.gsub(/https?:\/\/[\S]+/,' \0 ').gsub(/[^@\s]+@(?:[-a-z0-9]+\.)+[a-z]{2,}/, ' \0 ').gsub(/[0-9|\-|\(|\)|\#|\+]{7,}/, ' \0 ')
		model.Source = for_staff.source
		model.Summary = for_staff.summary
		model.Read = for_staff.read
		model.CreatedAt = for_staff.created_at
		model.Favorite = for_staff.favorite
		model.Like = for_staff.like
		model.CanFavorite = true
		model.CanLike = true
		model.Organizer = for_staff.admin.display
		model.OrganizerAvatar = !for_staff.admin.icon.exists? ? '' : Rails.configuration.host + for_staff.admin.icon.url(:medium)
		model.Images = []
		model.AccountId = for_staff.admin.id

<<<<<<< HEAD
		for_staff.information_images.each do |image|
			unless image.nil?
=======
		for_staff.for_staff_images.each do |image|
			if !image.nil? && image.file.exists?
>>>>>>> master
				model.Images << Rails.configuration.host + image.file.url
			end
		end
		
		if user
			model.CanFavorite = for_staff.can_favorite(user)
			model.CanLike = for_staff.can_like(user)
		end

		model
	end
end