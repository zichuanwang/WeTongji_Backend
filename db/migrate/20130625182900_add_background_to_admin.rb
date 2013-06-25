class AddBackgroundToAdmin < ActiveRecord::Migration
  def up
    add_column :admins, :background_file_name, :string
    add_column :admins, :background_content_type, :string
    add_column :admins, :background_file_size, :integer
    add_column :admins, :background_updated_at, :datetime
  end

  def down
  	remove_column :admins, :background_file_name
    remove_column :admins, :background_content_type
    remove_column :admins, :background_file_size
    remove_column :admins, :background_updated_at
  end
end
