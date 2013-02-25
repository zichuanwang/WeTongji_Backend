module Api
	module FriendsHelper
		def friend_invite
			if verify_action_params(['U', 'S', 'No'])
				user = verify_user_authentication
				if user
					invite = FriendInvite.invite(user, params[:No])
					if invite
						invite.save
						re = ApiReturn.new("000")
					else
						re = ApiReturn.new("015")
					end
					
					return_response(re)
				end
			end
		end

		def friend_invite_accept
			if verify_action_params(['U', 'S', 'Id'])
				user = verify_user_authentication
				if user
					friend_invite = FriendInvite.find(params[:Id])
					
					if friend_invite
						friend_invite.accept
						re = ApiReturn.new("000")
					else
						re = ApiReturn.new("012")
					end
					
					return_response(re)
				end
			end
		end

		def friend_invite_reject
			if verify_action_params(['U', 'S', 'Id'])
				user = verify_user_authentication
				if user
					friend_invite = FriendInvite.find(params[:Id])
					
					if friend_invite
						friend_invite.reject
						re = ApiReturn.new("000")
					else
						re = ApiReturn.new("012")
					end
					
					return_response(re)
				end
			end
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