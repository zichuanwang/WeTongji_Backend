# encoding: utf-8

# third, generate course take
SeleCourse.select("student_no, course_no, begin, end").group("student_no, course_no, begin, end").each do |s|
	uno_prefix = ''
	if s["begin"] < '2012/07/01'
		uno_prefix = '1201'
	elsif s["begin"] < '2013/02/01'
		uno_prefix = '1202'
	elsif s["begin"] < '2013/08/01'
		uno_prefix = '1301'
	end

	take = CourseTake.new
	take.student_no = s["student_no"].to_s
	take.course_uno = uno_prefix + s["course_no"].to_s
	take.save
	p "course " + take.course_uno + " take!"
end

p "course take done!"