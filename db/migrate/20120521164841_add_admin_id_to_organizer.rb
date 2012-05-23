class AddAdminIdToOrganizer < ActiveRecord::Migration
  def change
  	add_column :organizers, :admin_id, :integer
  end
end
