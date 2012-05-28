class DeleteSubOrganizer < ActiveRecord::Migration
  def up
  	drop_table :sub_organizers
  end

  def down
    create_table :sub_organizers do |t|
      t.string :name
      t.string :description
      t.integer :organizer_id

      t.timestamps
    end
  end
end
