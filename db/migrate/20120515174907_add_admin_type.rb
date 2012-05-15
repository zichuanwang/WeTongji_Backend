class AddAdminType < ActiveRecord::Migration
  def up
  	add_column :admins, :role, :string
  end

  def down
  	remove_column :admins, :role
  end
end
