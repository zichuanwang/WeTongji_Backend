class DestoryStoryComment < ActiveRecord::Migration
  	def up
  		drop_table :story_comments
  	end

  	def down
		create_table :story_comments do |t|
		t.string :body
		t.integer :user_id
		t.integer :story_id
		t.boolean :is_pending, :default => false
		t.boolean :visiable, :default => true
		t.string :pending_reason

		t.timestamps
    	end
  	end
end
