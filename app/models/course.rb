# encoding: utf-8
require 'csv'
class Course < ActiveRecord::Base
	paginates_per 20
  	has_many :course_sections, :foreign_key => "course_uno", :primary_key => "uno"
end