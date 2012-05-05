class AddOrganizerIcon < ActiveRecord::Migration
  def up
    add_column :organizers, :icon_file_name, :string
    add_column :organizers, :icon_content_type, :string
    add_column :organizers, :icon_file_size, :integer
    add_column :organizers, :icon_updated_at, :datetime
  end

  def down
  	remove_column :organizers, :icon_file_name
    remove_column :organizers, :icon_content_type
    remove_column :organizers, :icon_file_size
    remove_column :organizers, :icon_updated_at
  end
end
