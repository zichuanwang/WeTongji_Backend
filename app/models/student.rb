class Student < ActiveRecord::Base
	validates_presence_of :name, :no, :email, :major, :navtiveplace, :degree, :department, :plan, :gender, :year, :birthday
end
