class CreateInformation < ActiveRecord::Migration
  def change
    create_table :information do |t|
      t.string :title
      t.text :context
      t.integer :read
      t.string :category
      t.boolean :is_pending
      t.boolean :visiable
      t.string :pending_reason

      t.timestamps
    end
  end
end
