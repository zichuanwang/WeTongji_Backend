class CreateStories < ActiveRecord::Migration
  def change
    create_table :stories do |t|
      t.string :title
      t.text :body
      t.integer :user_id
		  t.string :image_file_name
  		t.string :image_content_type
  		t.integer :image_file_size
  		t.datetime :image_updated_at
  		t.boolean :is_pending, :default => false
  		t.boolean :visiable, :default => true
  		t.string :pending_reason
  		t.integer :story_comments_count

      t.timestamps
    end
  end
end
