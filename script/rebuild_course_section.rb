# encoding: utf-8
Course.all.each do |c|
	student_no_array = SeleCourse.where(:course_no => c.no).uniq.pluck(:student_no)
	if student_no_array.length > 0
		student_no = student_no_array[0]
		SeleCourse.where(:student_no => student_no, :course_no => c.no).each do |s|
			section = CourseSection.new
			section.location = s.location
			section.week_type = s.week_type
			section.course_no = s.course_no
			section.week_day = s.week_day
			section.section_start = s.section_start
			section.section_end = s.section_end
			section.save
			p "build timetable for #{c.no}"
		end
	end
end
Course.all.each do |c|
	student_no_array = SeleCourse.where(:course_no => c.no).uniq.pluck(:student_no)
	if student_no_array.length > 0
		student_no = student_no_array[0]
        SeleCourse.select("student_no, course_no, begin, end").group("student_no, course_no, begin, end").each do |s|
			take = CourseTake.new
			take.student_no = s["student_no"]
			take.course_no = s["course_no"]
			take.begin = s["begin"]
			take.end = s["end"]
			take.save
			p "build take #{take.student_no} at #{take.course_no}"
        end
	end
end