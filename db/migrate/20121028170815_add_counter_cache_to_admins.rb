class AddCounterCacheToAdmins < ActiveRecord::Migration
  def up
  	add_column :admins, :news_count, :integer, :default => 0
  	add_column :admins, :information_count, :integer, :default => 0
  	add_column :admins, :activities_count, :integer, :default => 0
  	Admin.all.each do |admin|
  		Admin.reset_counters admin.id, :news
  		Admin.reset_counters admin.id, :information
  		Admin.reset_counters admin.id, :activities
  	end
  end

  def down
  	remove_column :admins, :news_count
  	remove_column :admins, :information_count
  	remove_column :admins, :activities_count
  end
end
