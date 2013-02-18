class ExUserProfile
	attr_accessor :CanBeFound, :AllowAddFriend, :PublicSchedule, :PublicScheduleToAll, :PublicInformation, :PublicInformationToAll

	def self.init_from_user_profile(user_profile)
		model = ExUserProfile.new
		model.CanBeFound = user_profile.can_be_found
		model.AllowAddFriend = user_profile.allow_add_friend
		model.PublicSchedule = user_profile.public_schedule
		model.PublicScheduleToAll = user_profile.public_schedule_to_all
		model.PublicInformation = user_profile.public_information
		model.PublicInformationToAll = user.user_profile.public_information_to_all
		model
	end

	def self.update_json_to_user_profile(json, user_profile)
		user_profile.can_be_found = json["UserProfile"]["CanBeFound"] == nil ? user_profile.can_be_found : json["UserProfile"]["CanBeFound"]
		user_profile.allow_add_friend = json["UserProfile"]["AllowAddFriend"] == nil ? user_profile.allow_add_friend : json["UserProfile"]["AllowAddFriend"]
		user_profile.public_schedule = json["UserProfile"]["PublicSchedule"] == nil ? user_profile.public_schedule : json["UserProfile"]["PublicSchedule"]
		user_profile.public_schedule_to_all = json["UserProfile"]["PublicScheduleToAll"] == nil ? user_profile.public_schedule_to_all : json["UserProfile"]["PublicScheduleToAll"]
		user_profile.public_information = json["UserProfile"]["PublicInformation"] == nil ? user_profile.public_information : json["UserProfile"]["PublicInformation"]
		user_profile.public_information_to_all = json["UserProfile"]["PublicInformationToAll"] == nil ? user_profile.public_information_to_all : json["UserProfile"]["PublicInformationToAll"]
		user_profile
	end
end