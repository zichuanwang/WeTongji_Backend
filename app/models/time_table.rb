# encoding: utf-8
class TimeTable
	def self.get_by_user(user)
		SeleCourse.where("student_no = :no and :now between begin and end", :no => user.no, :now => Time.now)
	end
end
