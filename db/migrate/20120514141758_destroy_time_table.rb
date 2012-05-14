class DestroyTimeTable < ActiveRecord::Migration
  def up
  	drop_table :time_tables
  end

  def down
  	create_table :time_tables do |t|
      t.integer :user_id

      t.timestamps
    end
  end
end
