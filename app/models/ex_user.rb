class ExUser
	attr_accessor :UID, :NO, :Name, :DisplayName, :Avatar, :Phone, :Email

	def self.init_from_user(user)
		model = ExUser.new
		model.UID = user.uid
		model.DisplayName = user.display_name
		model.Avatar = user.avatar ? '' : user.avatar.url
		#model.Phone = user.phone
		model.Email = user.email
		model.NO = user.no
		model
	end

	def self.init_from_json(json)
		model = ExUser.new
		model.DisplayName = json["DisplayName"]
		model
	end

	def update_user(user)
		user.display_name = self.DisplayName
		user.email = self.Email
		user
	end
end