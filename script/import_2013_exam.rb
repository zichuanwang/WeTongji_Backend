require 'action_view'
require 'csv'
include ActionView::Helpers::DateHelper

p Rails.root
p "#{Rails.root}/public/imports/2013_exam.csv"
csv_text = File.read("#{Rails.root}/public/imports/2013_exam.csv")
b = Time.now
csv = CSV.parse(csv_text, :headers => true)

csv.each_with_index do |row, index|
	s = Exam.new
	s.student_no = row[0]
	s.course_no = row[1]
	s.begin = row[2]
	s.end = row[3]
	s.location = row[4]
	p "import no:#{index} row!"
	s.save
end

e = Time.now
p "import task done in #{distance_of_time_in_words(b, e, true)}"
