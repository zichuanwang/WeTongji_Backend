class AdminAndChannels < ActiveRecord::Migration
  def change
    create_table :admins_channels do |t|
      t.integer :admin_id
      t.integer :channel_id

      t.timestamps
    end
  end
end
