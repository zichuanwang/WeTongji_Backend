# encoding: utf-8
class TimeTable
	def self.get_by_user(user, begin_at, end_at)
		instance = []
		1.upto(10) do |i|
			c = CourseInstance.new
			c.id = i
			c.hours = 100
			c.begin = "2012/01/01 12:00:00"
			c.end = "2012/01/01 12:45:00"
			c.teacher = "老师A" + i.to_s
			c.location = "地址A" + i.to_s
			c.name = "课程A" + i.to_s
			instance << c
		# courses = SeleCourse.where("student_no = :no", :no => user.no)
		# begin.up(end).each do |day|

		# end
		end
		instance
	end
end
