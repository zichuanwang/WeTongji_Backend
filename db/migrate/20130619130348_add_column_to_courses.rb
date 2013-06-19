class AddColumnToCourses < ActiveRecord::Migration
  def up
    add_column :courses, :uno, :string
    add_column :courses, :begin, :datetime
    add_column :courses, :end, :datetime
    remove_column :course_sections, :course_no
    add_column :course_sections, :course_uno, :string
    remove_column :course_takes, :course_no
    add_column :course_takes, :course_uno, :string

  end

  def down
    remove_column :courses, :uno
    remove_column :courses, :begin
   	remove_column :courses, :end
    add_column :course_sections, :course_no, :string
    remove_column :course_sections, :course_uno
    add_column :course_takes, :course_no, :string
    remove_column :course_takes, :course_uno
  end
end
