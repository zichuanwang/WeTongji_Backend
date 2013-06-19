class RenameExamColumn < ActiveRecord::Migration
  def up
  	rename_column :exams, :course_no, :course_uno
  end

  def down
  	rename_column :exams, :course_uno, :course_no
  end
end
