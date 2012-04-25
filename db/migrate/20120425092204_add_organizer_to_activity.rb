class AddOrganizerToActivity < ActiveRecord::Migration
  def change
  	remove_column :activities, :organizer
  	add_column :activities, :organizer_id, :integer
  end
end
