class RenameNotificationColumn < ActiveRecord::Migration
  def up
  	rename_column :notifications, :type, :out_model_name
  end

  def down
  	rename_column :notifications, :out_model_name, :type
  end
end
