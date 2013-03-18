class ExSeleCourseInstance
	attr_accessor :NO, :Name, :Teacher, :Hours, :Location, :SectionStart, :SectionEnd, :Point, :Required, :Day

	def self.init_from_sele_course_instance(instance)
		model = ExSeleCourseInstance.new

		model.NO = instance.no
		model.Teacher = instance.teacher
		model.Name = instance.name
		model.Location = instance.location
		model.Hours = instance.hours
		model.Point = instance.point
		model.SectionStart = instance.section_start
		model.SectionEnd = instance.section_end
		model.Required = instance.required
		model.Day = instance.day

		model
	end
end