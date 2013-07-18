# encoding: utf-8
class ExCourse
	attr_accessor :NO, :UNO, :Name, :Teacher, :Hours, :Sections, :Point, :Required, :FriendsCount, :IsAudit, :Like, :CanLike

	def self.init_from_course(course, user = nil)
		ex = ExCourse.new

		unless course.nil?
			ex.NO = course.no
			ex.UNO = course.uno
			ex.Name = course.name
			ex.Teacher = course.teacher
			ex.Hours = course.hours
			ex.Point = course.point
			ex.Required = course.required
			ex.FriendsCount = 0
			ex.Like = UserLike.get_count("Course", course.id)
			ex.CanLike = user.nil? false : UserLike.can?("Course", course.id, user.id)
			ex.Sections = []

			course.course_sections.each do |item|
				ex.Sections << ExCourseSection.init_from_course_section(item)
			end

			unless user.nil?
				ex.FriendsCount = 0
				ex.IsAudit = user.audit_courses.exists?(course)
			end
		end

		ex
	end
end