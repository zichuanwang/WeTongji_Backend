class CreateSchoolNews < ActiveRecord::Migration
  def change
    create_table :school_news do |t|
      t.string :title
      t.string :source
      t.string :summary
      t.string :context
      t.integer :read
      t.integer :like
      t.integer :favorite
      t.integer :admin_id
      t.boolean :is_pending, :default => false
      t.boolean :visiable, :default => true
      t.string :pending_reason

      t.timestamps
    end

    create_table :school_news_users_favorites do |t|
      t.integer :user_id
        t.integer :school_news_id
    end

    create_table :school_news_users_likes do |t|
        t.integer :user_id
        t.integer :school_news_id
    end

    create_table :school_news_images do |t|
      t.integer :school_news_id
      t.string :file_file_name
      t.string :file_content_type
      t.integer :file_file_size
      t.datetime :file_updated_at
      t.timestamps
    end
  end
end
