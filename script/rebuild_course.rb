# encoding: utf-8

# first, generate uno 
SeleCourse.select("course_no, begin, end").group("course_no, begin, end").each do |s|
	uno_prefix = ''
	if s["begin"] < '2012/03/01'
		uno_prefix = '1201'
	elsif s["begin"] < '2012/10/01'
		uno_prefix = '1202'
	elsif s["begin"] < '2013/03/01'
		uno_prefix = '1301'
	end

	course_with_uno = Course.find_by_uno(uno_prefix + s["course_no"].to_s)

	if course_with_uno.nil?
		course = Course.find_by_no(s["course_no"].to_s)
		unless course.nil?
			c_new = Course.new
			c_new.no = course.no
			c_new.uno = uno_prefix + course.no.to_s
			c_new.name = course.name
			c_new.teacher = course.teacher
			c_new.point = course.point
			c_new.required = course.required
			c_new.hours = course.hours
			c_new.begin = s["begin"]
			c_new.end = s["end"]
			c_new.save
			p "uno " + uno_prefix + s["course_no"].to_s
		end
	end
end

p "uno generate done!"