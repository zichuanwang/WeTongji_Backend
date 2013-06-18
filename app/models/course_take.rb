class CourseTake < ActiveRecord::Base
  attr_accessible :course_no, :student_no, :begin, :end
end
