# encoding: utf-8
class TimeTable
	def self.get_by_user(user)
		instance = []
		courses = SeleCourse.where("student_no = :no", :no => user.no)
		
		courses.each do |course|
			i = CourseInstance.new
			i.no = course.course_no
			i.teacher = course.teacher
			i.location = course.location
			i.week_type = course.week_type
			i.week_day = course.week_day
			i.section_start = course.section_start
			i.section_end = course.section_end
			c = Course.find_by_no(course.course_no)
			if c
				i.hours = c.hours
				i.point = c.point
				i.required = c.required
				i.name = c.name
			end
			instance << i
		end

		instance
	end
end
