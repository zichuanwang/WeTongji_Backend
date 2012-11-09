class AddOtherSomeColumnsToInformation < ActiveRecord::Migration
  	def change
  		add_column :information, :image_file_name, :string
	    add_column :information, :image_content_type, :string
	    add_column :information, :image_file_size, :integer
	    add_column :information, :image_updated_at, :datetime
	    add_column :information, :location, :string
	    add_column :information, :contact, :string
	    add_column :information, :addition, :string
  	end
end
