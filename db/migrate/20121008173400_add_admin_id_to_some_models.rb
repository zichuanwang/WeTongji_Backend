class AddAdminIdToSomeModels < ActiveRecord::Migration
  def change
  	add_column :news, :admin_id, :integer
  	add_column :information, :admin_id, :integer
  	add_column :activities, :admin_id, :integer
  end
end
