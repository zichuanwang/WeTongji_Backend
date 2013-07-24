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
							#find history invites and delete them
							all = CourseInvite.where("`from` = :from and `to` = :to", :from => invite.from, :to => invite.to)
							all.each do |item|
								Notification.delete_all("out_model_name = 'CourseInvite' and out_id = :id", :id => item.id)
								item.destroy
							end


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

						noti = Notification.new
						noti.title = "#{invite.to_user.name}已经接受你的邀请."
						noti.user = invite.from_user
						noti.out_id = invite.id
						noti.out_model_name = "CourseInvite"
						noti.save

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

						#remove these code at 3.1
						noti = Notification.find_by_out_model_name_and_out_id("CourseInvite", params[:Id])
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

		def courses_get_by_user
			if verify_action_params(['U', 'S', 'Begin', 'End'])
				user = verify_user_authentication
				if user
					u = user
					ex = []
					if params["UID"]
						friend = user.friends.joins("left join users u on u.id = friends.other_user_id").where("u.uid = :uid", :uid => params[:UID]).first
						if friend
							u = friend.other_user
						end
					end
					all_c = Schedule.get_courses_by_user(u, params[:Begin], params[:End])
					all_c.each do |item|
						ex << ExCourse.init_from_course(item, u)
					end

					re = ApiReturn.new("000")
					re.add_data("Courses", ex)
					return_response(re)
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