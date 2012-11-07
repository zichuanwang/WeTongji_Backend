class CreatePersonImages < ActiveRecord::Migration
  def change
    create_table :person_images do |t|
      	t.string :title
    	t.integer :person_id
    	t.string :file_file_name
    	t.string :file_content_type
    	t.integer :file_file_size
    	t.datetime :file_updated_at
      	t.timestamps
    end
  end
end
