class AddTopColumnToInformation < ActiveRecord::Migration
  def change
  	add_column :information, :top, :boolean, :default => false
  	add_column :activities, :top, :boolean, :default => false
  end
end
