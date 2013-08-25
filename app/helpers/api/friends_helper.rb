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
							#find history invites and delete them
							all = FriendInvite.where("`from` = :from and `to` = :to", :from => invite.from, :to => invite.to)
							all.each do |item|
								Notification.where("out_model_name = 'FriendInvite' and out_id = :id", :id => item.id).delete_all
								item.destroy
							end

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
					invite = FriendInvite.find_by_id(params[:Id])
					
					if invite && invite.to_user == user
						invite.accept

						noti = Notification.new
						noti.title = "#{invite.to_user.name}已经接受你的邀请."
						noti.user = invite.from_user
						noti.out_id = invite.id
						noti.out_model_name = "FriendInvite"
						noti.save

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
					invite = FriendInvite.find_by_id(params[:Id])
					
					if invite && invite.to_user == user
						invite.reject

						#remove these code at 3.1
						noti = Notification.find_by_out_model_name_and_out_id("FriendInvite", params[:Id])
						unless noti.nil?
							noti.rejected_at = invite.rejected_at
							noti.save
						end

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

		#todo 有bug
		def friends_with_same_friend
			if verify_action_params(['U', 'S', 'UID'])
				user = verify_user_authentication
				if user
					ex = []
					friends = user.friends.joins("left join friends f on f.user_id = friends.other_user_id").joins("left join users u on u.id = f.user_id").where("u.uid = :uid", :uid => params[:UID])
					friends.each do |item|
						ex << ExUser.init_from_user(item.other_user, user)
					end
					re = ApiReturn.new("000")
					re.add_data("Users", ex)
					return_response(re)
				end
			end
		end

		def friends_get_by_user
			if verify_action_params(['U', 'S', 'UID'])
				user = verify_user_authentication
				if user
					friend = User.find_by_uid(params[:UID])
					#friend = user.friends.joins("left join users u on u.id = friends.other_user_id").where("u.uid = :uid", :uid => params[:UID]).first
					if friend
						ex = []
						friend.friends.each do |item|
							ex << ExUser.init_from_user(item, user)
						end
						re = ApiReturn.new("000")
						re.add_data("Users", ex)
						return_response(re)
					else
						re = ApiReturn.new("017")
						return_response(re)
					end
				end
			end
		end

		def friend_get
			if verify_action_params(['U', 'S', 'UID'])
				user = verify_user_authentication
				if user
					friend = user.friends.joins("left join users u on u.id = friends.other_user_id").where("u.uid = :uid", :uid => params[:UID]).first
					if friend
						ex = ExUser.init_from_user(friend.other_user)
						re = ApiReturn.new("000")
						re.add_data("User", ex)
					else
						re = ApiReturn.new("017")
						return_response(re)
					end

					return_response(re)
				end
			end
		end
	end
end
