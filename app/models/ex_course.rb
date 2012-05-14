class ExCourse
	attr_accessor :Id, :Begin, :End, :Name, :Teacher, :Hours, :Location

	def self.init_from_course_instance(instance)
		model = ExCourse.new
		model.Id = instance.id
		model.Teacher = instance.teacher
		model.Name = instance.name
		model.Location = instance.location
		model.Begin = instance.begin
		model.End = instance.end

		model
	end
end