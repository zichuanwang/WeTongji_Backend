require 'action_view'
require 'csv'
include ActionView::Helpers::DateHelper

p Rails.root
p "#{Rails.root}/public/imports/2013_winter_exam.csv"
csv_text = File.read("#{Rails.root}/public/imports/2013_winter_exam.csv")
b = Time.now
csv = CSV.parse(csv_text, :headers => true)

csv.each_with_index do |row, index|
	s = Exam.new
	s.student_no = row[0]
	s.course_uno = "1302#{row[1]}"
	s.begin = row[3]
	s.end = row[4]
	s.location = row[5]
	p "import no:#{index} row!"
	s.save
end

e = Time.now
p "import task done in #{distance_of_time_in_words(b, e, true)}"
