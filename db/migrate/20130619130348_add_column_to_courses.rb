class AddColumnToCourses < ActiveRecord::Migration
  def change
    add_column :courses, :uno, :string
    add_column :courses, :begin, :datetime
    add_column :courses, :end, :datetime
    remove_column :course_sections, :course_no
    add_column :course_sections, :course_uno, :string
    remove_column :course_takes, :course_no
    add_column :course_takes, :course_uno, :string
  end
end
