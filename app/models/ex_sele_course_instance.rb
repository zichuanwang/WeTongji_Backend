class ExSeleCourseInstance
	attr_accessor :NO, :Name, :Teacher, :Hours, :Location, :SectionStart, :SectionEnd, :Point, :Required, :Day, :IsSelfSechedule

	def self.init_from_sele_course_instance(instance, self_schedule = false)
		model = ExSeleCourseInstance.new

		unless instance.nil?
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
			model.IsSelfSechedule = instance.is_self_schedule
		end

		model
	end
end