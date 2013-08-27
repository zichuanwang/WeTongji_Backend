# encoding: utf-8
require 'action_view'
require 'csv'
include ActionView::Helpers::DateHelper

p Rails.root
p "#{Rails.root}/public/imports/2013_autumn_students.csv"
csv_text = File.read("#{Rails.root}/public/imports/2013_autumn_students.csv")
b = Time.now
csv = CSV.parse(csv_text, :headers => true)
csv.each_with_index do |row, index|
	s = Student.new
	s.name = row[0]
	s.no = row[2]
	s.email = "#{row[2]}@tongji.edu.cn"
	s.major = row[4]
	s.department = row[3]
	s.plan = row[6]
	s.gender = row[1]
	s.year = row[5]
	s.birthday = row[7]
	p "import no:#{index} row!"
	s.save
	p s.errors
end
e = Time.now
p "import task done in #{distance_of_time_in_words(b, e, true)}"
