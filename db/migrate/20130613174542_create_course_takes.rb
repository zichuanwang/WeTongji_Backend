class CreateCourseTakes < ActiveRecord::Migration
  def change
    create_table :course_takes do |t|
      t.string :student_no
      t.string :course_no

      t.timestamps
    end
  end
end
