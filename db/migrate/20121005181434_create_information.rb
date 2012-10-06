class CreateInformation < ActiveRecord::Migration
  def change
    create_table :information do |t|
      t.string :title
      t.text :context
      t.integer :read
      t.string :category
      t.boolean :is_pending, :default => false
      t.boolean :visiable, :default => true
      t.string :pending_reason
      t.string :image_file_name
      t.string :image_content_type
      t.integer :image_file_size
      t.datetime :image_updated_at

      t.timestamps
    end
  end
end
