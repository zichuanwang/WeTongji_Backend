class ExPerson
	attr_accessor :Id, :Name, :JobTitle, :Words, :Description, :Read, :Like, :Favorite, :CanLike, :CanFavorite, 
				  :Images, :NO, :Avatar, :StudentNO, :CreatedAt

	def self.init_from_person(person, user = nil)
		model = ExPerson.new
		unless person.nil?
			model.Id = person.id
			model.Name = person.name
			model.Description = person.description#.gsub(/https?:\/\/[\S]+/,' \0 ').gsub(/[^@\s]+@(?:[-a-z0-9]+\.)+[a-z]{2,}/, ' \0 ').gsub(/[0-9|\-|\(|\)|\#|\+]{7,}/, ' \0 ')
			model.Read = person.read
			model.Words = person.words
			model.JobTitle = person.job_title
			model.Favorite = person.favorite
			model.Like = UserLike.get_count("Person", model.Id)
			model.CanFavorite = true
			model.CanLike = true
			model.Images = Hash.new
			model.StudentNO = person.student_no
			model.Avatar = !person.avatar.exists? ? '' : Rails.configuration.host + person.avatar.url
			model.NO = person.no
			model.CreatedAt = person.created_at

			person.person_images.each do |image|
				if !image.nil? && image.file.exists?
					model.Images[Rails.configuration.host + image.file.url] = image.title
				end
			end
			
			if user
				model.CanFavorite = person.can_favorite(user)
				model.CanLike = person.can_like(user)
			end
		end

		model
	end
end