class CreateUserProfiles < ActiveRecord::Migration
  def change
    create_table :user_profiles do |t|
      t.integer :user_id
      t.boolean :can_be_found, :default => false
      t.boolean :allow_add_friend, :default => false
      t.boolean :public_schedule, :default => false
      t.boolean :public_schedule_to_all, :default => false
      t.boolean :public_information, :default => false
      t.boolean :public_information_to_all, :default => false

      t.timestamps
    end
  end
end
