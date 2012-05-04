class ExUser
	attr_accessor :UID, :NO, :Name, :DisplayName, :Avatar, :Phone, :Email

	def self.init_from_user(user)
		model = ExUser.new
		model.UID = user.uid
		model.DisplayName = user.display_name
		#model.Avatar = user.avatar
		#model.Phone = user.phone
		model.Email = user.email
		model.NO = user.no
		model
	end
end