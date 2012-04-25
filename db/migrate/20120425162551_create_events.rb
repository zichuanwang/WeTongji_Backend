class CreateEvents < ActiveRecord::Migration
  def change
    create_table :events do |t|
      t.integer :user_id
      t.datetime :begin
      t.datetime :end
      t.string :title
      t.string :location
      t.string :description

      t.timestamps
    end
  end
end
