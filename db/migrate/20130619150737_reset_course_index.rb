class ResetCourseIndex < ActiveRecord::Migration
  def up
  	remove_index "courses", :name => "index_courses_on_no"
    add_index "courses", ["no"], :name => "index_courses_on_no", :unique => false
    add_index "courses", ["uno"], :name => "index_courses_on_uno", :unique => true
  end

  def down
    remove_index "courses", :name => "index_courses_on_no"
    remove_index "courses", :name => "index_courses_on_uno"
    add_index "courses", ["no"], :name => "index_courses_on_no", :unique => true
  end
end
