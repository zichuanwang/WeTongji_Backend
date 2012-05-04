class AddUserColumns < ActiveRecord::Migration
  def up
    add_column :channels, :image_file_name, :string
    add_column :channels, :image_content_type, :string
    add_column :channels, :image_file_size, :integer
    add_column :channels, :image_updated_at, :datetime

    add_column :students, :major, :string
    add_column :students, :navtiveplace, :string
    add_column :students, :degree, :string
  end

  def down
    remove_column :channels, :image_file_name
    remove_column :channels, :image_content_type
    remove_column :channels, :image_file_size
    remove_column :channels, :image_updated_at

    remove_column :students, :major
    remove_column :students, :navtiveplace
    remove_column :students, :degree

  end
end
