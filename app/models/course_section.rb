class CourseSection < ActiveRecord::Base
  attr_accessible :location, :course_uno, :section_end, :section_start, :week_day, :week_type
end
