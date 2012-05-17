# encoding: utf-8
require 'importex'
class StudentImport < Importex::Base
  column "学号", :required => true
  column "姓名", :required => true
  column "学院", :required => false
  column "专业", :required => false
  column "学制", :required => false
  column "性别", :required => false
  column "入学年份", :required => false
  column "出生日期", :required => false, :type => Date

  def self.get_students
  	students = []
  	StudentImport.all.each do |item|
  		s = Student.new
  		if Student.find_by_no(item['学号'])
  			s = Student.find_by_no(item['学号'])
  		end
  		s.no = item['学号']
  		s.name = item['姓名']
  		s.email = s.no + "@tongji.edu.cn"
  		s.major = item['专业']
  		s.department = item['学院']
  		s.plan = item['学制']
  		s.gender = item['性别']
  		s.year = item['入学年份']
  		s.birthday = item['出生日期']
  		students << s
  	end
  	students
  end
end