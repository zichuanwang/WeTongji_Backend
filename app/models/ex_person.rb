class ExPerson
	attr_accessor :ID, :Name, :JobTitle, :Words, :Title, :Description, :Read, :Like, :Favorite, :CanLike, :CanFavorite

	def self.init_from_person(person)
		model = ExPerson.new
		# model.UID = user.uid
		# model.DisplayName = user.display_name
		# model.Avatar = user.avatar == nil ? '' : Rails.configuration.host + user.avatar.url
		# model.Phone = user.phone
		# model.Email = user.email
		# model.Name = user.name
		# model.NO = user.no
		# model.Major = user.major
		# model.NativePlace = user.native_place
		# model.Degree = user.degree
		# model.Gender = user.gender
		# model.Year = user.year
		# model.Birthday = user.birthday
		# model.Plan = user.plan
		# model.SinaWeibo = user.sina_weibo
		# model.QQ = user.qq
		# model.Department = user.department
		model
	end
end