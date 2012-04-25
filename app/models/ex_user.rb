class ExUser
	attr_accessor :UID, :DisplayName, :Avatar, :Phone, :Email

	def self.init_from_user(user)
		model = ExUser.new
		model.UID = user.uid
		model.DisplayName = user.DisplayName
		model.Avatar = user.avatar
		model.Phone = user.phone
		model.Email = user.email
		model
	end
end