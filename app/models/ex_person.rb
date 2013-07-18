class ExPerson
	attr_accessor :Id, :Name, :JobTitle, :Words, :Description, :Read, :Like, :CanLike, 
				  :Images, :NO, :Avatar, :StudentNO, :CreatedAt

	def self.init_from_person(person, user = nil)
		model = ExPerson.new
		unless person.nil?
			model.Id = person.id
			model.Name = person.name
			model.Description = person.description
			model.Read = person.read
			model.Words = person.words
			model.JobTitle = person.job_title
			model.Like = UserLike.get_count("Person", model.Id)
			model.CanLike = user.nil? ? false : UserLike.can?("Person", person.id, user.id)
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
			
		end

		model
	end
end