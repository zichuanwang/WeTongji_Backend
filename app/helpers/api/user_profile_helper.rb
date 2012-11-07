module Api
	module UserProfileHelper
		
		def favorite
			if verify_action_params(['U', 'S'])
				user = verify_user_authentication
				if user
					activities = user.favorite_activities
					p = params[:P].nil? ? 1 : params[:P].to_i

					activities = activities.page(p).per(20)

					ex = []
					activities.each do |activity|
						ex << ExActivity.init_from_activity(activity, user)
					end
					re = ApiReturn.new("000")
					re.add_data("NextPager", (p < activities.num_pages ? p + 1 : 0))
					re.add_data("Activities", ex)
					return_response(re)
				end
			end
		end

		def schedule
			if verify_action_params(['U', 'S', 'Begin', 'End'])
				user = verify_user_authentication
				if user
					activities = Schedule.get_activities_by_user(user, params[:Begin], params[:End])
				
					ac = []
					activities.each do |activity|
						ac << ExActivity.init_from_activity(activity, user)
					end

					exams = Schedule.get_exams_by_user(user, params[:Begin], params[:End])
					ex = []
					exams.each do |exam|
						ex << ExExam.init_from_exam_instance(exam)
					end

					re = ApiReturn.new("000")
					re.add_data("Activities", ac)
					re.add_data("Exams", ex)
					return_response(re)
				end
			end
		end

		#timetable
		def timetable
			if verify_action_params(['U', 'S'])
				user = verify_user_authentication
				if user
					courses = TimeTable.get_by_user(user)
					ex = []
					courses.each do |c|
						ex << ExCourse.init_from_course_instance(c)
					end
					re = ApiReturn.new("000")
					re.add_data("Courses", ex)
					re.add_data("SchoolYearStartAt", Rails.configuration.data_of_school_year_start)
					re.add_data("SchoolYearWeekCount", Rails.configuration.week_of_school_year)
					re.add_data("SchoolYearCourseWeekCount", Rails.configuration.week_of_school_year_in_course)
					return_response(re)
				end
			end
		end
	end
end