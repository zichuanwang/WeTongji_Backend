class ExUser
	attr_accessor :UID, :NO, :Name, :DisplayName, :Avatar, :Phone, :Email, :Major, 
				:NativePlace, :Degree, :Gender, :Year, :Birthday, :Plan, :SinaWeibo, :QQ, :Department,
				:Room, :RoomNO, :UserType, :Words, :IsFriend, :LikeCount, :FriendCount, :Like

	def self.init_from_user(user, current_user = nil)
		model = ExUser.new
		unless user.nil?
			model.UID = user.uid
			model.DisplayName = user.display_name
			model.Avatar = !user.avatar.exists? ? '' : Rails.configuration.host + user.avatar.url
			model.Phone = user.phone
			model.Email = user.email
			model.Name = user.name
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
			model.Room = user.room
			model.RoomNO = user.room_no
			model.UserType = user.user_type
			model.Words = user.words
			model.Like = UserLike.get_count("User", user.id)

			model.LikeCount = {}
			model.LikeCount["User"] = user.user_likes.where("out_model_name = 'User'").count
			model.LikeCount["Activity"] = user.user_likes.where("out_model_name = 'Activity'").count
			model.LikeCount["Story"] = user.user_likes.where("out_model_name = 'Story'").count
			model.LikeCount["Information"] = user.user_likes.where("out_model_name = 'Information'").count
			model.LikeCount["Account"] = user.user_likes.where("out_model_name = 'Account'").count
			model.LikeCount["Person"] = user.user_likes.where("out_model_name = 'Person'").count

			model.FriendCount = user.friends.count

			model.IsFriend = false
			unless current_user.nil?
				model.IsFriend = Friend.keep?(current_user.id, user.id)
			end
		end
		
		model
	end

	def self.update_json_to_user(json, user)
		user.display_name = json["User"]["DisplayName"] == nil ? user.display_name : json["User"]["DisplayName"]
		user.email = json["User"]["Email"] == nil ? user.email : json["User"]["Email"]
		user.qq = json["User"]["QQ"] == nil ? user.qq : json["User"]["QQ"]
		user.phone = json["User"]["Phone"] == nil ? user.phone : json["User"]["Phone"]
		user.sina_weibo = json["User"]["SinaWeibo"] == nil ? user.sina_weibo : json["User"]["SinaWeibo"]
		user.room = json["User"]["Room"] == nil ? user.sina_weibo : json["User"]["Room"]
		user.room_no = json["User"]["RoomNO"] == nil ? user.sina_weibo : json["User"]["RoomNO"]
		user.words = json["User"]["Words"] == nil ? user.words : json["User"]["Words"]
		user
	end
end