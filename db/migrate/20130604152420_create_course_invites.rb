class CreateCourseInvites < ActiveRecord::Migration
  def change
    create_table :course_invites do |t|
      t.datetime :accepted_at
      t.integer :from
      t.string :from_name
      t.integer :to
      t.string :to_name
      t.datetime :rejected_at
      t.integer :sele_course_id

      t.timestamps
    end

    create_table :sele_courses_users_schedules do |t|
      t.integer :user_id
      t.integer :sele_course_id
    end
  end
end
