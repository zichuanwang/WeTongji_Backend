class ExUser
	attr_accessor :UID, :NO, :Name, :DisplayName, :Avatar, :Phone, :Email, :Major, 
								:NativePlace, :Degree, :Gender, :Year, :Birthday, :Plan, :SinaWeibo, :QQ, :Department

	def self.init_from_user(user)
		model = ExUser.new
		model.UID = user.uid
		model.DisplayName = user.display_name
		model.Avatar = user.avatar ? '' : user.avatar.url
		model.Phone = user.phone
		model.Email = user.email
		model.NO = user.no
		model.Major = user.major
		model.NativePlace = user.native_place
		model.Degree = user.degree
		model.Gender = user.gender
		model.Year = user.year
		model.Birthday = user.birthday
		model.Plan = user.plan
		model.SinaWeibo = user.sina_weibo
		model.QQ = user.qq
		model.Department = user.department
		model
	end

	def self.init_from_json(json)
		model = ExUser.new
		model.DisplayName = json["DisplayName"]
		model.QQ = json["QQ"]
		model.Email = json["Email"]
		model.Phone = json["Phone"]
		model.SinaWeibo = json["SinaWeibo"]
		model
	end

	def update_user(user)
		user.display_name = self.DisplayName
		user.email = self.Email
		user.qq = self.QQ
		user.phone = self.Phone
		user.sina_weibo = self.SinaWeibo
		user
	end
end