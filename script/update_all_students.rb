# encoding: utf-8
require 'action_view'
require 'csv'
include ActionView::Helpers::DateHelper

p Rails.root
p "#{Rails.root}/public/imports/all_students.csv"
csv_text = File.read("#{Rails.root}/public/imports/all_students.csv")
b = Time.now
csv = CSV.parse(csv_text, :headers => true)
csv.each_with_index do |row, index|
	s = Student.find_by_no(row[0])
	if s.nil?
		s = Student.new
		s.email = "#{row[0]}@tongji.edu.cn"
	end
	s.no = row[0]
	s.name = row[1]
	s.gender = row[2]
	s.department = row[4]
	s.major = row[5]
	s.year = row[6]
	s.plan = row[7]
	s.birthday = row[8]
	p "import no:#{index} row!"
	s.save
end
e = Time.now
p "import task done in #{distance_of_time_in_words(b, e, true)}"