class CreateIndexForCourses < ActiveRecord::Migration
  def up
    add_index "course_sections", ["course_uno"], :name => "index_course_sections_on_course_uno", :unique => false
    add_index "course_takes", ["course_uno"], :name => "index_course_takes_on_course_uno", :unique => false
  end

  def down
  	remove_index :name => "index_course_sections_on_course_uno"
  	remove_index :name => "index_course_takes_on_course_uno"
  end
end
