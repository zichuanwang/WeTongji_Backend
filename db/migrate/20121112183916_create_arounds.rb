class CreateArounds < ActiveRecord::Migration
  def change
    create_table :arounds do |t|
      t.string :title
      t.string :source
      t.string :summary
      t.string :context
      t.integer :read
      t.integer :like
      t.integer :favorite
      t.integer :admin_id
      t.string :location
      t.string :contact
      t.string :ticket_service
      t.boolean :is_pending, :default => false
      t.boolean :visiable, :default => true
      t.string :pending_reason
      t.string :image_file_name
      t.string :image_content_type
      t.integer :image_file_size
      t.datetime :image_updated_at

      t.timestamps
    end

    create_table :arounds_users_favorites do |t|
      t.integer :user_id
        t.integer :around_id
    end

    create_table :arounds_users_likes do |t|
        t.integer :user_id
        t.integer :around_id
    end

    create_table :arounds_images do |t|
      t.integer :around_id
      t.string :file_file_name
      t.string :file_content_type
      t.integer :file_file_size
      t.datetime :file_updated_at
      t.timestamps
    end
  end
end
