class ExCourse
	attr_accessor :NO, :Name, :Teacher, :Hours, :Location, :WeekType, :WeekDay, :SectionStart, :SectionEnd, :Point, :Required

	def self.init_from_course_instance(instance)
		model = ExCourse.new

		model.NO = instance.no
		model.Teacher = instance.teacher
		model.Name = instance.name
		model.Location = instance.location
		model.Hours = instance.hours
		model.Point = instance.point
		model.WeekDay = instance.week_day
		model.WeekType = instance.week_type
		model.SectionStart = instance.section_start
		model.SectionEnd = instance.section_end
		model.Required = instance.required

		model
	end
end