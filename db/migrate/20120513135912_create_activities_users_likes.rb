class CreateActivitiesUsersLikes < ActiveRecord::Migration
  def change
    create_table :activities_users_likes do |t|
      t.string :uid
      t.integer :activity_id

      t.timestamps
    end
  end
end
