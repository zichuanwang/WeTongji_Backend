# encoding: utf-8
module Api
	module FriendsHelper
		def friend_invite
			if verify_action_params(['U', 'S', 'UIDs'])
				user = verify_user_authentication
				if user
					params[:UIDs].split(',').each do |uid|
						invite = FriendInvite.invite(user, uid)
						if invite
							invite.save
							noti = Notification.new
							noti.title = "#{invite.from_user.name}邀请你加为好友."
							noti.user = invite.to_user
							noti.out_id = invite.id
							noti.out_model_name = "FriendInvite"
							noti.save
						end
					end
					
					re = ApiReturn.new("000")
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

		def friends_with_same_course
			if verify_action_params(['U', 'S', 'UNO'])
				user = verify_user_authentication
				if user
					ex = []
					friends = user.friends.joins("left join audit_courses a on a.user_id = friends.other_user_id").joins("left join courses c on c.id = a.course_id").where("c.uno = :uno", :uno => params[:UNO])
					friends.each do |item|
						ex << ExUser.init_from_user(item.other_user, user)
					end
					re = ApiReturn.new("000")
					re.add_data("Users", ex)
					return_response(re)
				end
			end
		end

		def friends_with_same_activity
			if verify_action_params(['U', 'S', 'Id'])
				user = verify_user_authentication
				if user
					ex = []
					friends = user.friends.joins("left join activities_users_schedules a on a.user_id = friends.other_user_id").where("a.activity_id = :id", :id => params[:Id])
					friends.each do |item|
						ex << ExUser.init_from_user(item.other_user, user)
					end
					re = ApiReturn.new("000")
					re.add_data("Users", ex)
					return_response(re)
				end
			end
		end
	end
end
