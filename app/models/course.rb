# encoding: utf-8
require 'csv'
class Course < ActiveRecord::Base
	paginates_per 20
  	has_many :course_sections, :foreign_key => "course_uno", :primary_key => "uno"

  	has_and_belongs_to_many :user_likes, :class_name => "User", :join_table => "user_likes", :foreign_key => "out_id", :conditions => "user_likes.out_model_name = 'Course'"
end