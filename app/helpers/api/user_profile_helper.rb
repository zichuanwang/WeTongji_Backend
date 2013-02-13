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

					#people
					people = user.favorite_people
					p = params[:P].nil? ? 1 : params[:P].to_i

					people = people.page(p).per(20)

					ex = []
					people.each do |person|
						ex << ExPerson.init_from_person(person, user)
					end
					re.add_data("People", ex)

					#school news
					school_news = user.favorite_school_news
					p = params[:P].nil? ? 1 : params[:P].to_i

					school_news = school_news.page(p).per(20)

					ex = []
					school_news.each do |school|
						ex << ExSchoolNews.init_from_school_news(school, user)
					end
					re.add_data("SchoolNews", ex)

					#club news
					club_news = user.favorite_club_news
					p = params[:P].nil? ? 1 : params[:P].to_i

					club_news = club_news.page(p).per(20)

					ex = []
					club_news.each do |club|
						ex << ExClubNews.init_from_club_news(club, user)
					end
					re.add_data("ClubNews", ex)

					#around
					arounds = user.favorite_arounds
					p = params[:P].nil? ? 1 : params[:P].to_i

					arounds = arounds.page(p).per(20)

					ex = []
					arounds.each do |around|
						ex << ExAround.init_from_around(around, user)
					end
					re.add_data("Arounds", ex)

					#for staff
					for_staffs = user.favorite_for_staffs
					p = params[:P].nil? ? 1 : params[:P].to_i

					for_staffs = for_staffs.page(p).per(20)

					ex = []
					for_staffs.each do |for_staff|
						ex << ExForStaff.init_from_for_staff(for_staff, user)
					end
					re.add_data("ForStaffs", ex)

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

		def user_update_profile
			if verify_action_params(['U', 'S', 'User'])
				user = verify_user_authentication
				if user
					unless user.user_profile
						user.user_profile = UserProfile.new
						user.save
					end
					ExUserProfile.update_json_to_user_profile(JSON.parse(params[:UserProfile]), user.user_profile)
					user.save
					ex = ExUserProfile.init_from_user_profile(user_profile.reload)
					re = ApiReturn.new("000")
					re.add_data("UserProfile", ex)
					return_response(re)
				end
			end
		end
	end
end