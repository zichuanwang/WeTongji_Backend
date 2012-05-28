class CreateExams < ActiveRecord::Migration
  def change
    create_table :exams do |t|
      t.string :student_no
      t.string :course_no
      t.datetime :begin
      t.datetime :end
      t.string :location

      t.timestamps
    end
  end
end
