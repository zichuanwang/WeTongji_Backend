class AddActivitiesChannelId < ActiveRecord::Migration
  def up
  	add_column :activities, :channel_id, :integer
  end

  def down
  	remove_column :activities, :channel_id
  end
end
