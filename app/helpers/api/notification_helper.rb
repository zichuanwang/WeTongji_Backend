module Api
	module NotificationHelper
		def notifications
			if verify_action_params(['U', 'S', 'OnlyNew'])
				user = verify_user_authentication
				if user
					p = params[:P].nil? ? 1 : params[:P].to_i

					items = user.notifications.where("rejected_at is null")
					if params[:OnlyNew] == "1"
						items = items.where("unread = true")
					end
					items = items.order("id desc").page(p).per(12)

					ex = []
					items.each do |n|
						n.unread = false
						n.save
						ex << ExNotification.init_from_notification(n, user)
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
