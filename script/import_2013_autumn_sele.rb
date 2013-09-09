# encoding: utf-8
require 'action_view'
require 'csv'
include ActionView::Helpers::DateHelper


csv_text = File.read("#{Rails.root}/public/imports/2013_autumn_courses_takes.csv")
b = Time.now
csv = CSV.parse(csv_text, :headers => true)
csv.each_with_index do |row, index|
	s = SeleCourse.new
	s.course_no = row[1]
	s.section_start = row[5]
	s.section_end = row[6]
	s.week_type = row[3]
	s.week_day = row[4]
	s.location = row[7]
	s.student_no = row[0]
	s.teacher = row[2]
	s.begin = '2013-09-01'
	s.end = '2014-01-06'

	s.save
	p "save sele course #{s.course_no} with #{s.student_no}"
end
e = Time.now
p "import task done in #{distance_of_time_in_words(b, e, true)}"