# encoding: utf-8
module Api
	module CoursesHelper
		def course_schedule
			if verify_action_params(['U', 'S', 'UNO'])
				user = verify_user_authentication
				if user
					user.audit_courses << Course.find_by_uno(params[:UNO])
					user.save
					re = ApiReturn.new("000")
					return_response(re)
				end
			end
		end

		def course_unschedule
			if verify_action_params(['U', 'S', 'UNO'])
				user = verify_user_authentication
				if user
					user.audit_courses.delete(Course.find_by_uno(params[:UNO]))
					user.save
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
						re.add_data("CourseInvite", ExCourseInvite.init_from_course_invite(invite, user))
					else
						re = ApiReturn.new("017")
					end
					return_response(re)
				end
			end
		end

		def course_invite
			if verify_action_params(['U', 'S', 'UIDs', 'UNO'])
				user = verify_user_authentication
				if user
					params[:UIDs].split(',').each do |uid|
						invite = CourseInvite.invite(user, uid, params[:UNO])
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

		def course_sections_get_by_user
			if verify_action_params(['U', 'S', 'UID', 'Begin', 'End'])
				user = verify_user_authentication
				if user
					friend = user.friends.joins("left join users u on u.id = friends.other_user_id").where("u.uid = :uid", :uid => params[:UID]).first
					if friend
						ex = []
						all_c = Schedule.get_courses_by_user(friend.other_user, params[:Begin], params[:End])
						all_c.each do |item|
							ex << ExCourseSection.init_from_course_section(item, friend.other_user)
						end

						re = ApiReturn.new("000")
						re.add_data("CourseSections", ex)
						return_response(re)
					else
						re = ApiReturn.new("017")
						return_response(re)
					end
				end
			end
		end

		def school_year_setting
			re = ApiReturn.new("000")
			re.add_data("SchoolYearStartAt", Rails.configuration.data_of_school_year_start)
			re.add_data("SchoolYearWeekCount", Rails.configuration.week_of_school_year)
			re.add_data("SchoolYearCourseWeekCount", Rails.configuration.week_of_school_year_in_course)
			return_response(re)
		end
	end
end