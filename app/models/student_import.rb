# encoding: utf-8
require 'importex'
class StudentImport < Importex::Base
  column "学号", :required => true
  column "姓名", :required => true
  column "学院", :required => true
  column "专业", :required => true
  column "学制", :required => true
  column "学历", :required => true
  column "性别", :required => true
  column "入学年份", :required => true
  column "籍贯", :required => true
  column "邮箱", :required => true
  column "生日", :required => true, :type => Date

  def self.get_students
  	students = []
  	StudentImport.all.each do |item|
  		s = Student.new
  		if Student.find_by_no(item['学号'])
  			s = Student.find_by_no(item['学号'])
  		end
  		s.no = item['学号']
  		s.name = item['姓名']
  		s.email = item['邮箱']
  		s.major = item['专业']
  		s.navtiveplace = item['籍贯']
  		s.degree = item['学历']
  		s.department = item['学院']
  		s.plan = item['学制']
  		s.gender = item['性别']
  		s.year = item['入学年份']
  		s.birthday = item['生日']
  		students << s
  	end
  	students
  end
end