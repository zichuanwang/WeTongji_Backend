# encoding: utf-8
module Api
	module FriendsHelper
		def friend_invite
			if verify_action_params(['U', 'S', 'UID'])
				user = verify_user_authentication
				if user
					invite = FriendInvite.invite(user, params[:UID])
					if invite
						invite.save
						noti = Notification.new
						noti.title = "#{invite.from_user.name}邀请你加为好友."
						noti.user = invite.to_user
						noti.out_id = invite.id
						noti.out_model_name = "FriendInvite"
						noti.save
						re = ApiReturn.new("000")
					else
						re = ApiReturn.new("015")
					end
					
					return_response(re)
				end
			end
		end

		def friend_invite_get
			if verify_action_params(['U', 'S', 'Id'])
				user = verify_user_authentication
				if user
					invite = FriendInvite.find_by_id(params[:Id])
					if invite && invite.to_user == user
						re = ApiReturn.new("000")
						re.add_data("User", ExUser.init_from_user(invite.to_user, user))
					else
						re = ApiReturn.new("017")
					end
					return_response(re)
				end
			end
		end

		def friend_invite_accept
			if verify_action_params(['U', 'S', 'Id'])
				user = verify_user_authentication
				if user
					friend_invite = FriendInvite.find_by_id(params[:Id])
					
					if friend_invite && friend_invite.to_user == user
						friend_invite.accept
						re = ApiReturn.new("000")
					else
						re = ApiReturn.new("017")
					end
					
					return_response(re)
				end
			end
		end

		def friend_invite_reject
			if verify_action_params(['U', 'S', 'Id'])
				user = verify_user_authentication
				if user
					friend_invite = FriendInvite.find_by_id(params[:Id])
					
					if friend_invite && friend_invite.to_user == user
						friend_invite.reject
						re = ApiReturn.new("000")
					else
						re = ApiReturn.new("017")
					end
					
					return_response(re)
				end
			end
		end

		def friends
			if verify_action_params(['U', 'S'])
				user = verify_user_authentication
				if user
					ex = []
					user.friends.each do |item|
						ex << ExUser.init_from_user(item.other_user, user)
					end
					re = ApiReturn.new("000")
					re.add_data("Users", ex)
					return_response(re)
				end
			end
		end

		def friend_remove
			if verify_action_params(['U', 'S', 'UID'])
				user = verify_user_authentication
				other = User.find_by_uid(params[:UID])
				if user && other
					Friend.break(user.id, other.id)
					re = ApiReturn.new("000")
					return_response(re)
				end
			end
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
	end
end
