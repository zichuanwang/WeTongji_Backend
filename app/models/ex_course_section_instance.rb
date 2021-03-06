class ExCourseSectionInstance
	attr_accessor :NO, :UNO, :Name, :Teacher, :Hours, :Location, :SectionStart, :SectionEnd, 
					:Point, :Required, :Day, :IsAudit, :WeekDay, :WeekType, :CourseDetails

	def self.init_from_course_section_instance(instance, user = nil)
		model = ExCourseSectionInstance.new

		unless instance.nil?
			model.NO = instance.no
			model.UNO = instance.uno
			model.Teacher = instance.teacher
			model.Name = instance.name
			model.Location = instance.location
			model.Hours = instance.hours
			model.Point = instance.point
			model.SectionStart = instance.section_start
			model.SectionEnd = instance.section_end
			model.Required = instance.required
			model.Day = instance.day
			model.IsAudit = instance.is_audit
			model.WeekDay = instance.week_day
			model.WeekType = instance.week_type
			model.CourseDetails = ExCourse.init_from_course(Course.find_by_uno(instance.uno), user)
		end

		model
	end
end