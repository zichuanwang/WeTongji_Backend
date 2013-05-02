class CreateComments < ActiveRecord::Migration
  def change
    create_table :comments do |t|
      t.integer :out_id
      t.string :out_model_name
      t.string :body
      t.boolean :is_anonymous
      t.integer :user_id
      t.boolean :visiable
      t.boolean :is_pending
      t.string :pending_reason

      t.timestamps
    end
  end
end
