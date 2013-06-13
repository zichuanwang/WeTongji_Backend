# encoding: utf-8
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
		sele_courses += user.schedule_sele_courses.where(":now between begin and end", :now => Time.now)
		#fetch days and search sele course at that day
		day = begin_at.to_datetime
		while day <= end_at.to_datetime
			#get day in week
			week_day = ''
			case day.strftime("%w")
			when "0"
				week_day = "星期日"
			when "1"
				week_day = "星期一"
			when "2"
				week_day = "星期二"
			when "3"
				week_day = "星期三"
			when "4"
				week_day = "星期四"
			when "5"
				week_day = "星期五"
			when "6"
				week_day = "星期六"
			end

			#get week type
			week_type = '单'
			if day.strftime("%U").to_i % 2 == 0
				week_type = '双'
			end

			#get sele course at that day
			sele_courses = SeleCourse.where("student_no = :no and :now between begin and end and week_day = :week_day and (week_type = :week_type or week_type = '全')", 
				:no => user.no, :now => Time.now, :week_day => week_day, :week_type => week_type)

			#generate sele course instance by day
			sele_courses.each do |sele|
				i = SeleCourseInstance.new
				i.no = sele.course_no
				i.location = sele.location
				i.section_start = sele.section_start
				i.section_end = sele.section_end
				i.teacher = sele.teacher
				i.day = day
				i.is_audit = false

				c = Course.find_by_no(sele.course_no)
				if c
					i.hours = c.hours
					i.point = c.point
					i.required = c.required
					i.name = c.name
				end

				sele_course_instances << i
			end

			sele_courses_1 = user.schedule_sele_courses.where(":now between begin and end and week_day = :week_day and (week_type = :week_type or week_type = '全')", 
				:now => Time.now, :week_day => week_day, :week_type => week_type)

			#generate sele course instance by day
			sele_courses_1.each do |sele|
				i = SeleCourseInstance.new
				i.no = sele.course_no
				i.location = sele.location
				i.section_start = sele.section_start
				i.section_end = sele.section_end
				i.teacher = sele.teacher
				i.day = day
				i.is_audit = true

				c = Course.find_by_no(sele.course_no)
				if c
					i.hours = c.hours
					i.point = c.point
					i.required = c.required
					i.name = c.name
				end

				sele_course_instances << i
			end

			day = day + 1
		end

		sele_course_instances
	end
	
end