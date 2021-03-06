# encoding: utf-8
require 'action_view'
require 'csv'
include ActionView::Helpers::DateHelper

b = Time.now

#Course.where('id >= 22250').delete_all
CourseSection.where('id >= 17494').delete_all

csv_text = File.read("#{Rails.root}/public/imports/new_course_sections.csv")
csv = CSV.parse(csv_text, :headers => true)
csv.each_with_index do |row, index|
	if Course.find_by_uno(row[0]).nil?
		c_org = Course.find_by_no(row[1])
		c = Course.new
		c.uno = row[0]
		c.no = row[1]
		c.teacher = row[2]

		unless c_org.nil?
			c.name = c_org.name
			c.point = c_org.point
			c.hours = c_org.hours
			c.required = c_org.required
			c.begin = '2013-09-09'
			c.end = '2014-01-05'
		end

		c.save

		p "save course #{c.uno}"
	end

	s = CourseSection.new
	s.course_uno = row[0]
	s.section_start = row[9]
	s.section_end = row[10]
	s.week_type = row[8]
	s.week_day = row[7]
	s.location = row[3]
	s.save
end

e = Time.now
p "import task done in #{distance_of_time_in_words(b, e, true)}"