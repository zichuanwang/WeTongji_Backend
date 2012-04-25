class ExStudent
	attr_accessor :No, :Name, :Major, :NativePlace, :Degree, :Email

	def self.init_from_student(student)
		model = ExStudent.new
		model.No = student.no
		model.Name = student.name
		model.Major = student.major
		model.NativePlace = student.nativeplace
		model.Degree = student.degree
		model.Email = student.email
		model
	end
end