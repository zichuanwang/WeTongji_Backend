class AuditCourse < ActiveRecord::Migration
  def changes
    create_table :audit_courses do |t|
      t.integer :user_id
      t.string :course_uno
    end
  end
end
