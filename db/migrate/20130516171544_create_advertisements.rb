class CreateAdvertisements < ActiveRecord::Migration
  def change
    create_table :advertisements do |t|
		t.string :title
		t.string :url
		t.integer :read
		t.string :bgcolor
		t.string :image_file_name
		t.string :image_content_type
		t.integer :image_file_size
		t.datetime :image_updated_at
      t.timestamps
    end
  end
end
