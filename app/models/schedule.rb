class Schedule
	def self.get_exams_by_user(user, begin_at, end_at)
		instance = []
		exams = Exam.where("begin >= :begin && end <= :end && student_no = :no", :no => user.no, :begin => begin_at, :end => end_at)
		
		exams.each do |exam|
			i = ExamInstance.new
			i.no = exam.course_no
			i.location = exam.location
			i.begin = exam.begin
			i.end = exam.end
			c = Course.find_by_no(exam.course_no)
			if c
				i.teacher = c.teacher
				i.name = c.name
				i.hours = c.hours
				i.point = c.point
				i.required = c.required
			end
			instance << i
		end

		instance
	end

	def self.get_activities_by_user(user, begin_at, end_at)
		user.schedule_activities.where("begin >= :begin && end <= :end", :begin => begin_at, :end => end_at)
	end

	def self.get_courses_by_user(user, begin_at, end_at)
		sele_course_instances = []
		#got take effect sele course first
		sele_courses = SeleCourse.where("student_no = :no and :now between begin and end", :no => user.no, :now => Time.now)

		#generate sele course instance by day
		sele_courses.each do |sele|
			i = SeleCourseInstance.new
			i.no = sele.course_no
			i.location = sele.location
			i.section_start = sele.section_start
			i.section_end = sele.section_end

			c = Course.find_by_no(sele.course_no)
			if c
				i.hours = c.hours
				i.point = c.point
				i.required = c.required
				i.name = c.name
			end

			sele_course_instances << i
		end

		sele_course_instances
	end
	
end