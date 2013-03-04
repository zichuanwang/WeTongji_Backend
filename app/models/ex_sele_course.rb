class ExSeleCourse
	attr_accessor :NO, :Name, :Teacher, :Hours, :Location, :WeekType, :WeekDay, :SectionStart, :SectionEnd, :Point, :Required

	def self.init_from_sele_course(sele)
		model = ExSeleCourse.new

		model.NO = sele.no
		model.Teacher = sele.teacher
		model.Name = sele.name
		model.Location = sele.location
		model.Hours = sele.hours
		model.Point = sele.point
		model.WeekDay = sele.week_day
		model.WeekType = sele.week_type
		model.SectionStart = sele.section_start
		model.SectionEnd = sele.section_end
		model.Required = sele.required

		c = Course.find_by_no(sele.course_no)
		if c
			model.Hours = c.hours
			model.Point = c.point
			model.Required = c.required
			model.Name = c.name
		end

		model
	end
end