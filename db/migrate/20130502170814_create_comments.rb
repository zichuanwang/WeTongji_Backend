class CreateComments < ActiveRecord::Migration
  def change
    create_table :comments do |t|
      t.integer :out_id
      t.string :out_model_name
      t.string :body
      t.boolean :is_anonymous, :default => false
      t.integer :user_id
      t.boolean :visiable, :default => true
      t.boolean :is_pending, :default => false
      t.string :pending_reason

      t.timestamps
    end
  end
end
