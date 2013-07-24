# encoding: utf-8
module Api
	module ActivitiesHelper
		def activities
			channel_ids = params[:Channel_Ids]
			sort = params[:Sort]
			p = params[:P].nil? ? 1 : params[:P].to_i
			uid = params[:UID]
			expire = params[:Expire]
			account_id = params[:Account_Id]

			activities = Activity.where("visiable = true")
			if uid
				user = User.find_by_uid(uid)
				if user
					activities = user.favorite_activities
				end
			end
			if account_id
				activities = activities.where(:admin_id => account_id)
			end
			if channel_ids
				activities = activities.where(:channel_id => channel_ids.split(','))
			end
			if sort
				activities = activities.order(sort)
			else
				activities = activities.order("begin asc")
			end

			unless expire && expire == '1'
				activities = activities.where("end > :end", :end => Time.now)
			end
			activities = activities.page(p).per(20)

			ex = []

			user = get_current_user

			activities.each do |activity|
				ex << ExActivity.init_from_activity(activity, user)
			end
			re = ApiReturn.new("000")
			re.add_data("NextPager", (p < activities.num_pages ? p + 1 : 0))
			re.add_data("Activities", ex)
			
			return_response(re)
		end

		def activities_get_by_user
			if verify_action_params(['U', 'S', 'UID'])
				user = verify_user_authentication
				if user

					friend = user.friends.joins("left join users u on u.id = friends.other_user_id").where("u.uid = :uid", :uid => params[:UID]).first
					if friend
						channel_ids = params[:Channel_Ids]
						sort = params[:Sort]
						p = params[:P].nil? ? 1 : params[:P].to_i
						expire = params[:Expire]
						activities = friend.other_user.schedule_activities.where("visiable = true")
						if channel_ids
							activities = activities.where(:channel_id => channel_ids.split(','))
						end
						if sort
							activities = activities.order(sort)
						else
							activities = activities.order("begin asc")
						end

						unless expire && expire == '1'
							activities = activities.where("end > :end", :end => Time.now)
						end
						activities = activities.page(p).per(20)

						ex = []
						
						activities.each do |activity|
							ex << ExActivity.init_from_activity(activity, user)
						end

						re = ApiReturn.new("000")
						re.add_data("NextPager", (p < activities.num_pages ? p + 1 : 0))
						re.add_data("Activities", ex)
						return_response(re)
					else
						re = ApiReturn.new("017")
						return_response(re)
					end
				end
			end
		end

		def activity_favorite
			if verify_action_params(['U', 'S', 'Id'])
				user = verify_user_authentication
				if user
					activity = Activity.find(params[:Id])
					if activity
						activity.user_favorite(user)
						activity.save
					end
					re = ApiReturn.new("000")
					return_response(re)
				end
			end
		end

		def activity_unfavorite
			if verify_action_params(['U', 'S', 'Id'])
				user = verify_user_authentication
				if user
					activity = Activity.find(params[:Id])
					if activity
						activity.user_unfavorite(user)
						activity.save
					end
					re = ApiReturn.new("000")
					return_response(re)
				end
			end
		end

		def	activity_like
			if verify_action_params(['U', 'S', 'Id'])
				user = verify_user_authentication
				if user
					activity = Activity.find(params[:Id])
					if activity
						activity.user_like(user)
						activity.save
					end
					re = ApiReturn.new("000")
					return_response(re)
				end
			end
		end

		def	activity_unlike
			if verify_action_params(['U', 'S', 'Id'])
				user = verify_user_authentication
				if user
					activity = Activity.find(params[:Id])
					if activity
						activity.user_unlike(user)
						activity.save
					end
					re = ApiReturn.new("000")
					return_response(re)
				end
			end
		end

		def activity_schedule
			if verify_action_params(['U', 'S', 'Id'])
				user = verify_user_authentication
				if user
					activity = Activity.find(params[:Id])
					if activity
						activity.user_schedule(user)
						activity.save
					end
					re = ApiReturn.new("000")
					return_response(re)
				end
			end
		end

		def activity_unschedule
			if verify_action_params(['U', 'S', 'Id'])
				user = verify_user_authentication
				if user
					activity = Activity.find(params[:Id])
					if activity
						activity.user_unschedule(user)
						activity.save
					end
					re = ApiReturn.new("000")
					return_response(re)
				end
			end
		end

		def activity_invite_get
			if verify_action_params(['U', 'S', 'Id'])
				user = verify_user_authentication
				if user
					invite = ActivityInvite.find_by_id(params[:Id])
					if invite && invite.to_user == user
						re = ApiReturn.new("000")
						re.add_data("AcivityInvite", ExActivityInvite.init_from_activity_invite(invite))
					else
						re = ApiReturn.new("017")
					end
					return_response(re)
				end
			end
		end

		def activity_invite
			if verify_action_params(['U', 'S', 'UIDs', 'Id'])
				user = verify_user_authentication
				if user
					params[:UIDs].split(',').each do |uid|
						invite = ActivityInvite.invite(user, uid, params[:Id])
						if invite
							invite.save
							noti = Notification.new
							noti.title = "#{invite.from_user.name}邀请你关注活动."
							noti.user = invite.to_user
							noti.out_id = invite.id
							noti.out_model_name = "ActivityInvite"
							noti.save
						end
					end

					re = ApiReturn.new("000")
					return_response(re)
				end
			end
		end

		def activity_invite_accept
			if verify_action_params(['U', 'S', 'Id'])
				user = verify_user_authentication
				if user
					invite = ActivityInvite.find_by_id(params[:Id])
					
					if invite && invite.to_user == user
						invite.accept

						noti = Notification.new
						noti.title = "#{invite.to_user.name}已经接受你的邀请."
						noti.user = invite.from_user
						noti.out_id = invite.id
						noti.out_model_name = "ActivityInvite"
						noti.save

						re = ApiReturn.new("000")
					else
						re = ApiReturn.new("017")
					end
					
					return_response(re)
				end
			end
		end

		def activity_invite_reject
			if verify_action_params(['U', 'S', 'Id'])
				user = verify_user_authentication
				if user
					invite = ActivityInvite.find_by_id(params[:Id])
					
					if invite && invite.to_user == user
						invite.reject

						#remove these code at 3.1
						noti = Notification.find_by_out_model_name_and_out_id("ActivityInvite", params[:Id])
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
	end
end