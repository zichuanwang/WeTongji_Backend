# encoding: utf-8
require 'importex'
class StudentImport < Importex::Base
  column "学号", :required => true, :type => String
  column "姓名", :required => true, :type => String
  column "学院", :required => true, :type => String
  column "专业", :required => true, :type => String
  column "学制", :required => true, :type => String
  column "学历", :required => true, :type => String
  column "性别", :required => true, :type => String
  column "入学年份", :required => true, :type => String
  column "籍贯", :required => true, :type => String
  column "邮箱", :required => true, :type => String
  column "生日",　:required => true, :type => Date

  def self.get_students
  	students = []
  	Product.all.each do |item|
  		s = Student.new
  		s.name = item['学号']
  		s.no = item['姓名']
  		s.email = item['邮箱']
  		s.major = item['专业']
  		s.navtiveplace = item['籍贯']
  		s.degree = item['学历']
  		s.department = item['学院']
  		s.plan = item['学制']
  		s.gender = item['性别']
  		s.year = item['入学年份']
  		s.birthday = item['生日']
  		students << sstudents
  	end
  	students
  end
end