# encoding: utf-8
module Api
	module CoursesHelper
		def course_schedule
			if verify_action_params(['U', 'S', 'Id'])
				user = verify_user_authentication
				if user
					course = SeleCourse.find_by_id(params[:Id])
					if course
						course.user_schedule(user)
						course.save
					end
					re = ApiReturn.new("000")
					return_response(re)
				end
			end
		end

		def course_unschedule
			if verify_action_params(['U', 'S', 'Id'])
				user = verify_user_authentication
				if user
					course = SeleCourse.find_by_id(params[:Id])
					if course
						course.user_unschedule(user)
						course.save
					end
					re = ApiReturn.new("000")
					return_response(re)
				end
			end
		end

		def course_invite_get
			if verify_action_params(['U', 'S', 'Id'])
				user = verify_user_authentication
				if user
					invite = CourseInvite.find_by_id(params[:Id])
					if invite && invite.to_user == user
						re = ApiReturn.new("000")
						re.add_data("CourseInvite", ExCourseInvite.init_from_course_invite(invite))
					else
						re = ApiReturn.new("017")
					end
					return_response(re)
				end
			end
		end

		def course_invite
			if verify_action_params(['U', 'S', 'UIDs', 'Id'])
				user = verify_user_authentication
				if user
					params[:UIDs].split(',').each do |uid|
						invite = CourseInvite.invite(user, uid, params[:Id])
						if invite
							invite.save
							noti = Notification.new
							noti.title = "#{invite.from_user.name}邀请你关注课程."
							noti.user = invite.to_user
							noti.out_id = invite.id
							noti.out_model_name = "CourseInvite"
							noti.save
						end
					end

					re = ApiReturn.new("000")
					return_response(re)
				end
			end
		end

		def course_invite_accept
			if verify_action_params(['U', 'S', 'Id'])
				user = verify_user_authentication
				if user
					invite = CourseInvite.find_by_id(params[:Id])
					
					if invite && invite.to_user == user
						invite.accept
						re = ApiReturn.new("000")
					else
						re = ApiReturn.new("017")
					end
					
					return_response(re)
				end
			end
		end

		def course_invite_reject
			if verify_action_params(['U', 'S', 'Id'])
				user = verify_user_authentication
				if user
					invite = CourseInvite.find_by_id(params[:Id])
					
					if invite && invite.to_user == user
						invite.reject
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