class AddSomeColumnsToInformation < ActiveRecord::Migration
  	def up
		add_column :information, :source, :string
		add_column :information, :summary, :text
		add_column :information, :like, :integer
		add_column :information, :favorite, :integer

		remove_column :information, :image_file_name
    	remove_column :information, :image_content_type
    	remove_column :information, :image_file_size
    	remove_column :information, :image_updated_at

		create_table :information_users_favorites do |t|
			t.integer :user_id
		  	t.integer :information_id
		end

		create_table :information_users_likes do |t|
		  	t.integer :user_id
		  	t.integer :information_id
		end

  	end

  	def down
  		remove_column :information, :source
  		remove_column :information, :summary
  		remove_column :information, :like
  		remove_column :information, :favorite

	    add_column :information, :image_file_name, :string
	    add_column :information, :image_content_type, :string
	    add_column :information, :image_file_size, :integer
	    add_column :information, :image_updated_at, :datetime

  		drop_table :information_users_likes
  		drop_table :information_users_favorites
  	end
end