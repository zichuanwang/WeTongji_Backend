module Api
	module FriendsHelper
		def friend_invite
			
		end

		def friend_invite_accept
			
		end

		def friend_invite_reject
			
		end

		def friends
			
		end

		def friend_remove
			# if verify_action_params(['U', 'S', 'Id'])
			# 	user = verify_user_authentication
			# 	if user
					
			# 	end
			# end
		end

		def friend_invites
			if verify_action_params(['U', 'S'])
				user = verify_user_authentication
				if user
					ex = []
					user.received_invites.each do |item|
						ex << ExFriendInvite.init_from_friend_invite(item)
					end
					ex = ExUserProfile.init_from_user_profile(user.user_profile.reload)
					re = ApiReturn.new("000")
					re.add_data("FriendInvites", ex)
					return_response(re)
				end
			end
		end
			# 	"Friend.Invite" => "friend_invite",
			# "Friend.Invite.Accept" => "friend_invite_accept",
			# "Friend.Invite.Reject" => "friend_invite_reject",
			# "Friends.Get" => "friends",
			# "Friend.Remove" => "friend_remove",
	end
end