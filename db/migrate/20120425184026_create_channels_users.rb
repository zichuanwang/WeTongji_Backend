class CreateChannelsUsers < ActiveRecord::Migration
  def change
    create_table :channels_users do |t|
      t.integer :user_id
      t.integer :channel_id

      t.timestamps
    end
  end
end
