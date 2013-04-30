class RemoveSomeUnuseColumnsFromInformationExternal < ActiveRecord::Migration
  def up
  	remove_column :information_externals, :image_file_name
    remove_column :information_externals, :image_content_type
    remove_column :information_externals, :image_file_size
    remove_column :information_externals, :image_updated_at
    remove_column :information_externals, :tags
  end

  def down
  	add_column :information_externals, :tags, :string
  	add_column :information_externals, :image_file_name, :string
  	add_column :information_externals, :image_content_type, :string
  	add_column :information_externals, :image_file_size, :integer
  	add_column :information_externals, :image_updated_at, :datetime
  end
end