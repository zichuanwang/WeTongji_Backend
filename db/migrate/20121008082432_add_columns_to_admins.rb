class AddColumnsToAdmins < ActiveRecord::Migration
  def change
    add_column :admins, :name, :string
    add_column :admins, :display, :string
    add_column :admins, :description, :text
    add_column :admins, :title, :string
    add_column :admins, :phone, :string
    add_column :admins, :address, :string
    add_column :admins, :student_no, :string    
    add_column :admins, :icon_file_name, :string
    add_column :admins, :icon_content_type, :string
    add_column :admins, :icon_file_size, :integer
    add_column :admins, :icon_updated_at, :datetime
  end
end
