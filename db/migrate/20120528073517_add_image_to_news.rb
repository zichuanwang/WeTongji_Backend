class AddImageToNews < ActiveRecord::Migration
  def change
  	add_column :news, :image_file_name, :string
    add_column :news, :image_content_type, :string
    add_column :news, :image_file_size, :integer
    add_column :news, :image_updated_at, :datetime
  end
end
