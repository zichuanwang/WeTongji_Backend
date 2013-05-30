module Api
	module NotificationHelper
		def notifications
			if verify_action_params(['U', 'S', 'OnlyNew'])
				user = verify_user_authentication
				if user
					p = params[:P].nil? ? 1 : params[:P].to_i

					items = user.notifications
					if params[:OnlyNew] == "1"
						items = items.where("unread = true")
					end
					items = items.order("id desc").page(p).per(12)

					ex = []
					items.each do |n|
						noti = ExNotification.init_from_notification(n)
						case n.out_model_name
						when 'FriendInvite'
							noti.SourceDetails = ExFriendInvite.init_from_friend_invite(FriendInvite.find_by_id(n.out_id))
						end
						n.unread = false
						n.save
						ex << noti
					end
					re = ApiReturn.new("000")
					re.add_data("NextPager", (p < items.num_pages ? p + 1 : 0))
					re.add_data("Notifications", ex)
					return_response(re)
				end
			end
		end
	end
end
