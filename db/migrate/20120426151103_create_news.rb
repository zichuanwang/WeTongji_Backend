class CreateNews < ActiveRecord::Migration
  def change
    create_table :news do |t|
      t.string :title
      t.string :context
      t.integer :read
      t.string :category

      t.timestamps
    end
  end
end
