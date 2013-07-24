class AddInviteColumnsToNotification < ActiveRecord::Migration
  def change
  	add_column :notifications, :rejected_at, :datetime
  end
end
