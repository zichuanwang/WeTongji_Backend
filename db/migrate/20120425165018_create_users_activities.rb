class CreateUsersActivities < ActiveRecord::Migration
  def change
    create_table :users_activities do |t|
      t.integer :user_id
      t.integer :activity_id

      t.timestamps
    end
  end
end
