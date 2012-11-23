class CreatePermissions < ActiveRecord::Migration
  def change
    create_table :permissions do |t|
      t.integer :admin_id
      t.string :flag

      t.timestamps
    end
  end
end
