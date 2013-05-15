module Api
	module NotificationHelper
		def notifications
			if verify_action_params(['U', 'S', 'UnRead'])
				user = verify_user_authentication
				if user
					p = params[:P].nil? ? 1 : params[:P].to_i

					items = Notification.where("unread = :flag", :flag => params[:UnRead]).order("id desc").page(p).per(12)

					ex = []
					items.each do |n|
						ex << ExNotification.init_from_notification(n)
					end
					re = ApiReturn.new("000")
					re.add_data("NextPager", (p < items.num_pages ? p + 1 : 0))
					re.add_data("Notifications", ex)
					return_response(re)
				end
			end
		end

		def notification_read
			if verify_action_params(['U', 'S', 'Id'])
				user = verify_user_authentication
				if user

					noti = user.notifications.where("id = :id", :id => params[:Id]).first
					if noti
						noti.unread = false
						noti.save
					end

					re = ApiReturn.new("000")
					return_response(re)
				end
			end
		end
	end
end