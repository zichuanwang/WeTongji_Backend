class ExUser
	attr_accessor :UID, :NO, :Name, :DisplayName, :Avatar, :Phone, :Email, :Major, 
				:NativePlace, :Degree, :Gender, :Year, :Birthday, :Plan, :SinaWeibo, :QQ, :Department,
				:Room, :UserType, :Words, :IsFriend, :LikeCount, :FriendCount, :Like, :ScheduleCount, :CanLike

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
			model.UserType = user.user_type
			model.Words = user.words
			model.Like = UserLike.get_count("User", user.id)
			model.CanLike = current_user.nil? ? false : UserLike.can?("User", user.id, current_user.id)
			model.IsFriend = false
			unless current_user.nil?
				model.IsFriend = Friend.keep?(current_user.id, user.id)
			end
			model.FriendCount = user.friends.count

			model.LikeCount = {}
			model.LikeCount["User"] = UserLike.get_like_count("User", user.id)
			model.LikeCount["Activity"] = UserLike.get_like_count("Activity", user.id)
			#model.LikeCount["Story"] = user.user_likes.where("out_model_name = 'Story'").distinct.count
			model.LikeCount["Information"] = UserLike.get_like_count("Information", user.id)
			model.LikeCount["Account"] = UserLike.get_like_count("Account", user.id)
			model.LikeCount["Person"] = UserLike.get_like_count("Person", user.id)
			model.LikeCount["Course"] = UserLike.get_like_count("Course", user.id)

			model.ScheduleCount = {}
			model.ScheduleCount["Activity"] = user.schedule_activities.count
			model.ScheduleCount["Course"] = user.audit_courses.count

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
		user.words = json["User"]["Words"] == nil ? user.words : json["User"]["Words"]
		user
	end
end
