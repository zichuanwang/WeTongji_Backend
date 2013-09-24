# encoding: utf-8
require 'action_view'
require 'csv'
include ActionView::Helpers::DateHelper

csv_text = File.read("#{Rails.root}/public/imports/2013_autumn_courses_takes.csv")

CourseTake.where('id >= 528506').delete_all
b = Time.now
csv = CSV.parse(csv_text, :headers => true)
csv.each_with_index do |row, index|
	if CourseTake.find_by_course_uno_and_student_no(row[1], row[0]).nil?
		t = CourseTake.new
		t.student_no = row[0]
		t.course_uno = row[1]
		t.save

		p "save take course #{t.course_uno} with #{t.student_no}"
	end
end

p 'course take refresh done'

e = Time.now
p "import task done in #{distance_of_time_in_words(b, e, true)}"