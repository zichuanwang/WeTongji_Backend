class CreateUserScheduleActivity < ActiveRecord::Migration
  def change
  	create_table :activities_users_schedules do |t|
      t.integer :user_id
      t.integer :activity_id

      t.timestamps
    end
  end
end
