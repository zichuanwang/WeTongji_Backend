class ExUserProfile
	attr_accessor :QuietMode, :PublicDetailsToAll, :PublicDetailsToFriends

	def self.init_from_user_profile(user_profile)
		model = ExUserProfile.new
		model.QuietMode = user_profile.quiet_mode
		model.PublicDetailsToFriends = user_profile.public_details_to_friends
		model.PublicDetailsToAll = user_profile.public_details_to_all
		model
	end

	def self.update_json_to_user_profile(json, user_profile)
		user_profile.quiet_mode = json["UserProfile"]["QuietMode"] == nil ? user_profile.can_be_found : json["UserProfile"]["QuietMode"]
		user_profile.public_details_to_friends = json["UserProfile"]["PublicDetailsToFriends"] == nil ? user_profile.allow_add_friend : json["UserProfile"]["PublicDetailsToFriends"]
		user_profile.public_details_to_all = json["UserProfile"]["PublicDetailsToAll"] == nil ? user_profile.public_schedule : json["UserProfile"]["PublicDetailsToAll"]
		user_profile
	end
end