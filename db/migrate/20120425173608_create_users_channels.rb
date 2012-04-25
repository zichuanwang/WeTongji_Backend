class CreateUsersChannels < ActiveRecord::Migration
  def change
    create_table :users_channels do |t|
      t.integer :user_id
      t.integer :channel_id

      t.timestamps
    end
  end
end
