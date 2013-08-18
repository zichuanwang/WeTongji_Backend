# encoding: utf-8
student = User.find_by_no('000000')

unless student.nil?
	CourseTake.where(:student_no => '1150443').each do |item|
		take = CourseTake.new
		take.student_no = '000000'
		take.course_uno = item.course_uno
		take.save
	end
end