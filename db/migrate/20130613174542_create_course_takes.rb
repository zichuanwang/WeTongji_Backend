class CreateCourseTakes < ActiveRecord::Migration
  def change
    create_table :course_takes do |t|
      t.string :student_no
      t.string :course_no
      t.datetime :begin
      t.datetime :end

      t.timestamps
    end
  end
end
