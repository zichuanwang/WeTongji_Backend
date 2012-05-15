class AddIndexForModels < ActiveRecord::Migration
  def up
  	add_index "students", ["no"], :name => "index_students_on_no", :unique => true
  	add_index "students", ["email"], :name => "index_students_on_email", :unique => true

  	add_index "courses", ["no"], :name => "index_courses_on_no", :unique => true

  	add_index "users", ["no"], :name => "index_users_on_no", :unique => true
  	add_index "users", ["encrypted_password"], :name => "index_users_on_encrypted_password", :unique => true
  	add_index "users", ["no", "encrypted_password"], :name => "index_users_on_no_and_encrypted_password", :unique => true
  	add_index "users", ["confirmation_token"], :name => "index_users_on_confirmation_token", :unique => true
  	add_index "users", ["uid"], :name => "index_users_on_uid", :unique => true
  	add_index "users", ["authentication_token"], :name => "index_users_on_authentication_token", :unique => true
  	add_index "users", ["uid", "authentication_token"], :name => "index_users_on_uid_and_authentication_token", :unique => true

  	add_index "sele_courses", ["student_no", "course_no"], :name => "index_sele_courses_on_student_no_and_course_no"
  end

  def down
  	remove_index "students", :name => "index_students_on_no"
  	remove_index "students", :name => "index_students_on_email"

  	remove_index "courses", :name => "index_courses_on_no"

  	remove_index "users", :name => "index_users_on_no"
  	remove_index "users", :name => "index_users_on_encrypted_password"
  	remove_index "users", :name => "index_users_on_no_and_encrypted_password"
  	remove_index "users", :name => "index_users_on_confirmation_token"
  	remove_index "users", :name => "index_users_on_uid"
  	remove_index "users", :name => "index_users_on_authentication_token"
  	remove_index "users", :name => "index_users_on_uid_and_authentication_token"

  	remove_index "sele_courses", :name => "index_sele_courses_on_student_no_and_course_no"

  end
end
