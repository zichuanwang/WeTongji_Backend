class CreateActivityInvites < ActiveRecord::Migration
  def change
    create_table :activity_invites do |t|
      t.integer :from
      t.string :from_name
      t.integer :to
      t.string :to_name
      t.datetime :accepted_at
      t.datetime :rejected_at
      t.integer :activity_id

      t.timestamps
    end
  end
end
