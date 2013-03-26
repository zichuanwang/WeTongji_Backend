require 'action_view'
require 'csv'
include ActionView::Helpers::DateHelper

p Rails.root
p "#{Rails.root}/public/imports/2013_spring_all_select_courses.csv"
csv_text = File.read("#{Rails.root}/public/imports/2013_spring_all_select_courses.csv")
b = Time.now
csv = CSV.parse(csv_text, :headers => true)
csv.each_with_index do |row, index|
	s = SeleCourse.new
	s.student_no = row[0]
	s.course_no = row[1]
	s.teacher = row[2]
	s.week_type = row[3]
	s.week_day = row[4]
	s.section_start = row[5]
	s.section_end = row[6]
	s.location = row[7]
	s.begin = '2013-02-25'
	s.end = '2013-07-08'
  p "import no:#{index} row!"
	s.save
end
e = Time.now
p "import task done in #{distance_of_time_in_words(b, e, true)}"
