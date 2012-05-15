class AddImageToActivity < ActiveRecord::Migration
  def change
    add_column :activities, :image_file_name, :string
    add_column :activities, :image_content_type, :string
    add_column :activities, :image_file_size, :integer
    add_column :activities, :image_updated_at, :datetime
  end
end
