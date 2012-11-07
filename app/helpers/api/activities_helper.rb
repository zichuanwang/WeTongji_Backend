module Api
	module ActivitiesHelper
		def activities
			channel_ids = params[:Channel_Ids]
			sort = params[:Sort]
			p = params[:P].nil? ? 1 : params[:P].to_i
			uid = params[:UID]
			expire = params[:Expire]

			activities = Activity.where("visiable = true")
			if uid
				user = User.find_by_uid(uid)
				if user
					activities = user.favorite_activities
				end
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

			user = User.get_authentication_user(params[:U], params[:S])

			activities.each do |activity|
				ex << ExActivity.init_from_activity(activity, user)
			end
			re = ApiReturn.new("000")
			re.add_data("NextPager", (p < activities.num_pages ? p + 1 : 0))
			re.add_data("Activities", ex)
			
			return_response(re)
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
	end
end