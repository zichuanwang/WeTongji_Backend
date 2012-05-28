class ExExam
	attr_accessor :NO, :Name, :Teacher, :Location, :Start, :End, :Point, :Required, :Hours

	def self.init_from_exam_instance(instance)
		model = ExExam.new
		model.NO = instance.no
		model.Name = instance.name
		model.Teacher = instance.teacher
		model.Begin = instance.begin
		model.End = instance.end
		model.Point = instance.point
		model.Hours = instance.hours
		model.Required = instance.required
		model.Location = instance.location
		model
	end
end