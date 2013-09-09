# encoding: utf-8
require 'action_view'
require 'csv'
include ActionView::Helpers::DateHelper

p Rails.root
p "#{Rails.root}/public/imports/2013_autumn_courses.csv"
csv_text = File.read("#{Rails.root}/public/imports/2013_autumn_courses.csv")
b = Time.now
csv = CSV.parse(csv_text, :headers => true)
csv.each_with_index do |row, index|
	c = Course.new
	c.no = row[0]
	c.name = row[1]
	c.uno = "1302#{row[0]}"
	c.teacher = row[2]
	c.point = row[3]
	c.hours = row[4]
	c.required = row[5]
	c.begin = '2013-09-01'
	c.end = '2014-01-06'
	c.save
end
e = Time.now
p "import task done in #{distance_of_time_in_words(b, e, true)}"
