class AddIndexForSearch < ActiveRecord::Migration
	def up
		add_index "students", ["name"], :name => "index_students_on_name", :unique => false
		add_index "users", ["name"], :name => "index_users_on_name", :unique => false
		add_index "course_takes", ["student_no"], :name => "index_course_takes_on_student_no", :unique => false
		add_index "course_sections", ["section_start"], :name => "index_course_sections_on_section_start", :unique => false
		add_index "course_sections", ["section_end"], :name => "index_course_sections_on_section_end", :unique => false
		add_index "courses", ["begin"], :name => "index_courses_on_begin", :unique => false
		add_index "courses", ["end"], :name => "index_courses_on_end", :unique => false
	end

	def down
		remove_index "students", :name => "index_students_on_name"
		remove_index "users", :name => "index_users_on_name"
		remove_index "course_takes", :name => "index_course_takes_on_student_no"
		remove_index "course_sections", :name => "index_course_sections_on_section_start"
		remove_index "course_sections", :name => "index_course_sections_on_section_end"
		remove_index "courses", :name => "index_courses_on_begin"
		remove_index "courses", :name => "index_courses_on_end"
	end
end
