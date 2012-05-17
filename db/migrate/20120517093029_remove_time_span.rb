class RemoveTimeSpan < ActiveRecord::Migration
  def up
  	remove_column :activities_users_favorites, :created_at
  	remove_column :activities_users_favorites, :updated_at
  	remove_column :activities_users_likes, :created_at
  	remove_column :activities_users_likes, :updated_at
  	remove_column :activities_users_schedules, :created_at
  	remove_column :activities_users_schedules, :updated_at
  	remove_column :channels_users, :created_at
  	remove_column :channels_users, :updated_at
  end

  def down
  	add_column :activities_users_favorites, :created_at, :datetime, :null => false
  	add_column :activities_users_favorites, :updated_at, :datetime, :null => false  	
  	add_column :activities_users_likes, :created_at, :datetime, :null => false
  	add_column :activities_users_likes, :updated_at, :datetime, :null => false
  	add_column :activities_users_schedules, :created_at, :datetime, :null => false
  	add_column :activities_users_schedules, :updated_at, :datetime, :null => false
  	add_column :channels_users, :created_at, :datetime, :null => false
  	add_column :channels_users, :updated_at, :datetime, :null => false
  end
end
