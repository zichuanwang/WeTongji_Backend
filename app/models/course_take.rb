class CourseTake < ActiveRecord::Base
  attr_accessible :course_no, :student_no, :begin, :end

	def self.rebuild
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
	end
end
