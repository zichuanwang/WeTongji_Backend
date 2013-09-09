# encoding: utf-8
require 'action_view'
require 'csv'
include ActionView::Helpers::DateHelper

def get_uno(base_nuo, uno, teacher)
	# if we have uno but teacher name different
	r = Course.find_by_uno(uno)
	unless r.nil?
		if r.teacher == teacher
			p "find uno #{uno}"
			return uno
		else
			return get_uno(base_nuo, "#{uno}0", teacher)
		end
	else
		p "new uno is #{uno}"
		return uno
	end
end

def copy_from(base_nuo, uno, teacher)
	c = Course.find_by_uno(base_nuo)

	unless c.nil?
		if Course.find_by_uno(uno).nil?
			c_new = Course.new
			c_new.no = c.no
			c_new.name = c.name
			c_new.point = c.point
			c_new.hours = c.hours
			c_new.required = c.required
			c_new.begin = c.begin
			c_new.end = c.end
			c_new.uno = uno
			c_new.teacher = teacher
			c_new.save
			p "copy from #{base_nuo} to #{uno} with teacher #{teacher}"
		end
	end
end

p Rails.root
p "#{Rails.root}/public/imports/2013_autumn_courses_takes.csv"
csv_text = File.read("#{Rails.root}/public/imports/2013_autumn_courses_takes.csv")
b = Time.now
csv = CSV.parse(csv_text, :headers => true)
csv.each_with_index do |row, index|
	s = CourseSection.new
	s.course_uno = get_uno("1302#{row[1]}", "1302#{row[1]}", row[2])
	s.section_start = row[5]
	s.section_end = row[6]
	s.week_type = row[3]
	s.week_day = row[4]
	s.location = row[7]

	unless CourseSection.where(:course_uno => s.course_uno, :section_start => s.section_start, :section_end => s.section_end, :week_day => s.week_day, :week_type => s.week_type, :location => s.location).exists?
		s.save
	end

	copy_from("1302#{row[1]}", s.course_uno, row[2])

	if CourseTake.find_by_course_uno_and_student_no(s.course_uno, row[0]).nil?
		t = CourseTake.new
		t.student_no = row[0]
		t.course_uno = s.course_uno
		t.save

		p "save take course #{t.course_uno} with #{t.student_no}"
	end
end
e = Time.now
p "import task done in #{distance_of_time_in_words(b, e, true)}"
