class CreateSubOrganizers < ActiveRecord::Migration
  def change
    create_table :sub_organizers do |t|
      t.string :name
      t.string :description
      t.integer :organizer_id

      t.timestamps
    end
  end
end
