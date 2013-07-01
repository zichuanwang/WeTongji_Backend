# encoding: utf-8
class Schedule
	def self.get_exams_by_user(user, begin_at, end_at)
		instance = []
		exams = Exam.where("begin >= :begin && end <= :end && student_no = :no", :no => user.no, :begin => begin_at, :end => end_at)
		
		exams.each do |exam|
			i = ExamInstance.new
			i.no = exam.course_uno[4, exam.course_uno.length - 4]
			i.uno = exam.course_uno
			i.location = exam.location
			i.begin = exam.begin
			i.end = exam.end
			c = Course.find_by_uno(exam.course_uno)
			unless c.nil?
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

	def self.get_course_section_instances_by_user(user, begin_at, end_at)
		course_section_instances = []
		
		# sections = Course.joins("left join course_sections on course_sections.course_uno = courses.uno").joins("left join course_takes on course_takes.course_uno = courses.uno")
		# 	.where("course_takes.student_no = :no and :now between begin and end", :no => user.no, :now => Time.now)
		# 	.select("courses.no as no, courses.uno as uno, courses.name as name, courses.teacher as teacher, courses.hours as hours, course_sections.location as location, course_sections.week_day as week_day, course_sections.week_type as week_type, course_sections.section_start as section_start, course_sections.section_end as section_end, courses.point as point, courses.required as required, course_sections.week_type as week_type, course_sections.week_day as week_day")

		sections_all = Course.joins("left join course_sections on course_sections.course_uno = courses.uno").joins("left join course_takes on course_takes.course_uno = courses.uno")
						.where("course_takes.student_no = :no and :now between courses.begin and courses.end", :no => user.no, :now => Time.now)
						.select("courses.no as no, courses.uno as uno, courses.name as name, courses.teacher as teacher, courses.hours as hours, course_sections.location as location, course_sections.week_day as week_day, course_sections.week_type as week_type, course_sections.section_start as section_start, course_sections.section_end as section_end, courses.point as point, courses.required as required, course_sections.week_type as week_type, course_sections.week_day as week_day")

		sections_all_audit = user.audit_courses.joins("left join course_sections on course_sections.course_uno = courses.uno").joins("left join course_takes on course_takes.course_uno = courses.uno")
						.where(":now between courses.begin and courses.end", :now => Time.now)
						.select("courses.no as no, courses.uno as uno, courses.name as name, courses.teacher as teacher, courses.hours as hours, course_sections.location as location, course_sections.section_start as section_start, course_sections.section_end as section_end, courses.point as point, courses.required as required, course_sections.week_type as week_type, course_sections.week_day as week_day")

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

			sections_all.each do |section|
				if section["week_day"] == week_day && (section["week_type"] == week_type || section["week_type"] == "全")
					i = CourseSectionInstance.new
					i.no = section["no"]
					i.uno = section["uno"]
					i.location = section["location"]
					i.section_start = section["section_start"]
					i.section_end = section["section_end"]
					i.teacher = section["teacher"]
					i.day = day
					i.is_audit = false
					i.hours = section["hours"]
					i.point = section["point"]
					i.required = section["required"]
					i.name = section["name"]
					i.week_day = section["week_day"]
					i.week_type = section["week_type"]

					course_section_instances << i
				end
			end

			sections_all_audit.each do |section|
				if section["week_day"] == week_day && (section["week_type"] == week_type || section["week_type"] == "全")
					i = CourseSectionInstance.new
					i.no = section["no"]
					i.uno = section["uno"]
					i.location = section["location"]
					i.section_start = section["section_start"]
					i.section_end = section["section_end"]
					i.teacher = section["teacher"]
					i.day = day
					i.is_audit = true
					i.hours = section["hours"]
					i.point = section["point"]
					i.required = section["required"]
					i.name = section["name"]
					i.week_day = section["week_day"]
					i.week_type = section["week_type"]

					course_section_instances << i
				end
			end

			day = day + 1
		end

		return course_section_instances

	end
	
	def self.get_courses_by_user(user, begin_at, end_at)
		sections_all = Course.joins("left join course_sections on course_sections.course_uno = courses.uno").joins("left join course_takes on course_takes.course_uno = courses.uno")
						.where("course_takes.student_no = :no and :now between courses.begin and courses.end", :no => user.no, :now => Time.now)
						.select("course_sections.*")

		sections_all_audit = user.audit_courses.joins("left join course_sections on course_sections.course_uno = courses.uno").joins("left join course_takes on course_takes.course_uno = courses.uno")
						.where(":now between courses.begin and courses.end", :now => Time.now)
						.select("course_sections.*")

		sections_all_audit + sections_all
	end
end