class CreateSeleCourses < ActiveRecord::Migration
  def change
    create_table :sele_courses do |t|
      t.string :student_no
      t.string :course_no
      t.string :teacher
      t.string :location
      t.string :week_type
      t.string :week_day
      t.integer :section_start
      t.integer :section_end

      t.timestamps
    end
  end
end
