class ExExam
	attr_accessor :NO, :Name, :Teacher, :Location, :Start, :End

	def self.init_from_exam_instance(instance)
		model = ExEaxm.new
		model.NO = instance.no
		model.Name = instance.title
		model.Teacher = instance.teacher
		model.Begin = instance.begin
		model.End = instance.end
		model.Location = instance.location
		model
	end
end