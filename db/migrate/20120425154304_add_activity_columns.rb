class AddActivityColumns < ActiveRecord::Migration
  def up
  	add_column :activities, :like, :integer
  	add_column :activities, :hot, :hot
  end

  def down
  	remove_column :activities, :like
  	remove_column :activities, :hot
  end
end
