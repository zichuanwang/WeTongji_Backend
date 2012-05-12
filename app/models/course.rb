# encoding: utf-8
require 'csv'
require 'iconv'
class Course < ActiveRecord::Base
	validates_presence_of :name, :no, :teacher, :point, :hours, :required
	validates_uniqueness_of :no
	paginates_per 10

	def self.import(file_path)
		courses = []

		csv_text = File.read(file_path)
		csv = CSV.parse(csv_text, :headers => true)
		csv.each do |row|
			s = Course.new
  		if Course.find_by_no(row[0])
  			s = Course.find_by_no(row[0])
  		end
  		s.no = row[0]
  		s.name = row[1]
  		s.teacher = row[2]
  		s.point = row[3]
  		s.hours = row[4]
  		s.required = row[5]
  		courses << s
		end

  	courses
  end
end