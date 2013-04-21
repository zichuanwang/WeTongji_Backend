class RestructInformationModel < ActiveRecord::Migration
  def up
  	remove_column :information, :source
  	remove_column :information, :summary
  	remove_column :information, :image_file_name
  	remove_column :information, :image_content_type
  	remove_column :information, :image_file_size
  	remove_column :information, :image_updated_at
  	remove_column :information, :location
  	remove_column :information, :contact
  	remove_column :information, :addition
  	add_column :information, :external_id, :integer
  end

  def down
  	add_column :information, :source, :string
  	add_column :information, :summary, :text
  	add_column :information, :image_file_name, :string
  	add_column :information, :image_content_type, :string
  	add_column :information, :image_file_size, :integer
  	add_column :information, :image_updated_at, :datetime
  	add_column :information, :location, :string
  	add_column :information, :contact, :string
  	add_column :information, :addition, :string
  end
end