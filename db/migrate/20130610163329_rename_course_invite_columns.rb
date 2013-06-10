class RenameCourseInviteColumns < ActiveRecord::Migration
  def up
  	remove_column :course_invites, :sele_course_id
  	add_column :course_invites, :student_no, :string
  	add_column :course_invites, :course_no, :string
  end

  def down
  	remove_column :course_invites, :student_no
  	remove_column :course_invites, :course_no
  	add_column :course_invites, :sele_course_id, :integer
  end
end
