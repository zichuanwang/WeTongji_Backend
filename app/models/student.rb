class Student < ActiveRecord::Base
	validates_presence_of :name, :no, :email, :major, :native_place, :degree, :department, :plan, :gender, :year, :birthday
	paginates_per 10
end
