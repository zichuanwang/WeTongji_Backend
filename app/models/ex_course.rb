# encoding: utf-8
class ExCourse
	attr_accessor :NO, :UNO, :Name, :Teacher, :Hours, :Sections, :Point, :Required, :FriendsCount, :IsAudit, :Like, :CanLike, :CanSchedule

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
			ex.CanLike = user.nil? ? false : UserLike.can?("Course", course.id, user.id)
			ex.Sections = []
			ex.CanSchedule = false

			course.course_sections.each do |item|
				ex.Sections << ExCourseSection.init_from_course_section(item)
			end

			unless user.nil?
				ex.FriendsCount = user.friends.joins("left join audit_courses a on a.user_id = friends.other_user_id").joins("left join courses c on c.id = a.course_id").where("c.uno = :uno", :uno => course.uno).count
				ex.IsAudit = user.audit_courses.exists?(course)
				unless ex.IsAudit
					take = CourseTake.find_by_student_no_and_course_uno(user.no, course.uno)
					if take.nil?
						ex.CanSchedule = true
					end
				end
			end
		end

		ex
	end
end