class RenameActivityColumns < ActiveRecord::Migration
  def up
  	rename_column :activities, :follow, :favorite
  	rename_column :activities, :hot, :schedule
  end

  def down
  	rename_column :activities, :favorite, :follow
  	rename_column :activities, :schedule, :hot
  end
end
