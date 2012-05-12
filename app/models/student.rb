# encoding: utf-8
require 'csv'
require 'iconv'
class Student < ActiveRecord::Base
	validates_presence_of :name, :no, :email
	validates_uniqueness_of :no, :email
	paginates_per 10

	def self.import(file_path)
		students = []

		csv_text = File.read(file_path)
		csv = CSV.parse(csv_text, :headers => true)
		csv.each do |row|
			s = Student.new
  		if Student.find_by_no(row[0])
  			s = Student.find_by_no(row[0])
  		end
  		s.no = row[0]
  		s.name = row[1]
  		s.gender = row[2]
  		s.birthday = row[3]
  		s.department = row[4]
  		s.major = row[5]
  		s.year = row[6]
  		s.plan = row[7]
  		s.email = s.no + "@tongji.edu.cn"
  		students << s
		end

  	students
  end
end
