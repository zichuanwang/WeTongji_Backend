class CreateNotifications < ActiveRecord::Migration
  def change
    create_table :notifications do |t|
      t.integer :user_id
      t.string :title
      t.string :type
      t.string :description
      t.integer :out_id
      t.boolean :unread, :default => true

      t.timestamps
    end
  end
end
