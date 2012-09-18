require 'csv'
class SeleCourse < ActiveRecord::Base
	validates_presence_of :course_no, :student_no, :location, :teacher, :week_type, :week_day, :section_start, :section_end
	paginates_per 10

	def self.import(file_path)
		courses = []

		csv_text = File.read(file_path)
		csv = CSV.parse(csv_text, :headers => true)
		csv.each do |row|
			s = SeleCourse.new
			s.student_no = row[0]
  		s.course_no = row[1]
  		s.teacher = row[2]
  		s.week_type = row[3]
  		s.week_day = row[4]
  		s.section_start = row[5]
  		s.section_end = row[6]
  		s.location = row[7]
  		s.begin = row[8]
  		s.end = row[9]
  		courses << s
		end

  		courses
  	end

end