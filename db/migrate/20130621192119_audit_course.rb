class AuditCourse < ActiveRecord::Migration
  def change
    create_table :audit_courses do |t|
      t.integer :user_id
      t.integer :course_id
    end
  end
end
