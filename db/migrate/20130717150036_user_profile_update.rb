class UserProfileUpdate < ActiveRecord::Migration
  def up
  	add_column :user_profiles, :public_details_to_all, :boolean, :default => false
  	add_column :user_profiles, :public_details_to_friends, :boolean, :default => false
  	add_column :user_profiles, :quiet_mode, :boolean, :default => false

  	remove_column :user_profiles, :can_be_found
  	remove_column :user_profiles, :allow_add_friend
  	remove_column :user_profiles, :public_schedule
  	remove_column :user_profiles, :public_schedule_to_all
  	remove_column :user_profiles, :public_information
  	remove_column :user_profiles, :public_information_to_all
  end

  def down
  	remove_column :user_profiles, :public_details_to_all
  	remove_column :user_profiles, :public_details_to_friends
  	remove_column :user_profiles, :quiet_mode

  	add_column :user_profiles, :can_be_found, :boolean, :default => false
  	add_column :user_profiles, :allow_add_friend, :boolean, :default => false
  	add_column :user_profiles, :public_schedule, :boolean, :default => false
  	add_column :user_profiles, :public_schedule_to_all, :boolean, :default => false
  	add_column :user_profiles, :public_information, :boolean, :default => false
  	add_column :user_profiles, :public_information_to_all, :boolean, :default => false
  end
end
