# encoding: utf-8

# first, generate uno 
# SeleCourse.select("course_no, begin, end").group("course_no, begin, end").each do |s|
# 	uno_prefix = ''
# 	if s["begin"] < '2012/03/01'
# 		uno_prefix = '1201'
# 	elsif s["begin"] < '2012/10/01'
# 		uno_prefix = '1202'
# 	elsif s["begin"] < '2013/03/01'
# 		uno_prefix = '1301'
# 	end

# 	course_with_uno = Course.find_by_uno(uno_prefix + s["course_no"])

# 	if course_with_uno.nil?
# 		course = Course.find_by_no(s["course_no"])
# 		unless course.nil?
# 			c_new = Course.new
# 			c_new.no = course.no
# 			c_new.uno = uno_prefix + course.no
# 			c_new.name = course.name
# 			c_new.teacher = course.teacher
# 			c_new.point = course.point
# 			c_new.required = course.required
# 			c_new.hours = course.hours
# 			c_new.begin = s["begin"]
# 			c_new.end = s["end"]
# 			c_new.save
# 			p uno_prefix + s["course_no"]
# 		end
# 	end

# 	Course.delete_all("uno is null")
# end

# second, generate course scetion
SeleCourse.select("course_no, begin, end, location, week_type, week_day, section_start, section_end").group("course_no, begin, end, location, week_type, week_day, section_start, section_end").each do |s|
	uno_prefix = ''
	if s["begin"] < '2012/03/01'
		uno_prefix = '1201'
	elsif s["begin"] < '2012/10/01'
		uno_prefix = '1202'
	elsif s["begin"] < '2013/03/01'
		uno_prefix = '1301'
	end
	section = CourseSection.new
	section.location = s["location"]
	section.week_type = s["week_type"]
	section.course_uno = uno_prefix + s["course_no"]
	section.week_day = s["week_day"]
	section.section_start = s["section_start"]
	section.section_end = s["section_end"]
	section.save
end

# third, generate course take
SeleCourse.select("student_no, course_no, begin, end").group("student_no, course_no, begin, end").each do |s|
	uno_prefix = ''
	if s["begin"] < '2012/03/01'
		uno_prefix = '1201'
	elsif s["begin"] < '2012/10/01'
		uno_prefix = '1202'
	elsif s["begin"] < '2013/03/01'
		uno_prefix = '1301'
	end

	take = CourseTake.new
	take.student_no = s["student_no"]
	take.course_uno = uno_prefix + s["course_no"]
	take.save

end