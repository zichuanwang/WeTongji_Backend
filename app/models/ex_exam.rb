class ExExam
	attr_accessor :NO, :UNO, :Name, :Teacher, :Location, :Begin, :End, :Point, :Required, :Hours

	def self.init_from_exam_instance(instance)
		model = ExExam.new
		unless instance.nil?
			model.NO = instance.no
			model.UNO = instance.uno
			model.Name = instance.name
			model.Teacher = instance.teacher
			model.Begin = instance.begin
			model.End = instance.end
			model.Point = instance.point
			model.Hours = instance.hours
			model.Required = instance.required
			model.Location = instance.location
		end
		model
	end
end