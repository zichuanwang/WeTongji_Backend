class ExPerson
	attr_accessor :Id, :Name, :JobTitle, :Words, :Title, :Description, :Read, :Like, :Favorite, :CanLike, :CanFavorite, :Images, :NO, :Avatar, :StudentNO

	def self.init_from_person(person, user = nil)
		model = ExPerson.new
		model.Id = person.id
		model.Name = person.name
		model.Title = person.title
		model.Description = person.description
		model.Read = person.read
		model.Words = person.words
		model.JobTitle = person.job_title
		model.Favorite = person.favorite
		model.Like = person.like
		model.CanFavorite = true
		model.CanLike = true
		model.Images = Hash.new
		model.StudentNO = person.student_no
		model.Avatar = person.avatar == nil ? '' : Rails.configuration.host + person.avatar.url
		model.NO = person.no

		person.person_images.each do |image|
			unless image.nil?
				model.Images[Rails.configuration.host + image.file.url] = image.title
			end
		end
		
		if user
			model.CanFavorite = person.can_favorite(user)
			model.CanSchedule = person.can_schedule(user)
			model.CanLike = person.can_like(user)
		end

		model
	end
end