class RemoveSubOrganizerIdFromActivity < ActiveRecord::Migration
  def up
  	remove_column :activities, :sub_organizer_id
  end

  def down
  	add_column :activities, :sub_organizer_id, :integer
  end
end
