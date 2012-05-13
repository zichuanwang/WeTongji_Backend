class ActivityNewAttribute < ActiveRecord::Migration
  def change
    create_table :activities_users_favorites do |t|
      t.integer :user_id
      t.integer :activity_id

      t.timestamps
    end
    create_table :activities_users_likes do |t|
      t.integer :user_id
      t.integer :activity_id

      t.timestamps
    end
    drop_table :activities_users
  end
end
