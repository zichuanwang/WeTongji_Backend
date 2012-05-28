class Schedule
	def self.get_exams_by_user(user)
		instance = []
		exams = Exam.where("student_no = :no", :no => user.no)
		
		exams.each do |exam|
			i = ExamInstance.new
			i.no = exam.course_no
			i.location = exam.location
			i.begin = exam.begin
			i.end = exam.end
			c = Course.find_by_no(course.course_no)
			if c
				i.teacher = c.teacher
				i.name = c.name
			end
			instance << i
		end

		instance
	end
	
end