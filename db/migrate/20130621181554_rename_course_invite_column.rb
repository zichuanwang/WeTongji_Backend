class RenameCourseInviteColumn < ActiveRecord::Migration
  def up
  	remove_column :course_invites, :course_uno
  	add_column :course_invites, :course_uno, :string
  end

  def down
  	remove_column :course_invites, :course_uno
  	add_column :course_invites, :course_no, :string
  end
end
