# encoding: utf-8
class ExCourse
	attr_accessor :NO, :Name, :Teacher, :Hours, :Sections, :Point, :Required

	def self.init_from_course(course)
		ex = ExCourse.new

		unless course.nil?
			ex.NO = course.no
			ex.Name = course.name
			ex.Teacher = course.teacher
			ex.Hours = course.hours
			ex.Point = course.point
			ex.Required = course.required
			ex.Sections = []

			course.course_sections.each do |item|
				ex.Sections << ExCourseSection.init_from_course_section(item)
			end
		end

		ex
	end
end