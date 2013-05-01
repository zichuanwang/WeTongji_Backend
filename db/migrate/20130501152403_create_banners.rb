class CreateBanners < ActiveRecord::Migration
  def change
    create_table :banners do |t|
      	t.string :title
      	t.string :url
	    t.string :image_file_name
	    t.string :image_content_type
	    t.integer :image_file_size
	    t.datetime :image_updated_at
	    t.integer :read

      	t.timestamps
    end
  end
end
