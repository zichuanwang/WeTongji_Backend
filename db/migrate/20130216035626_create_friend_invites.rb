class CreateFriendInvites < ActiveRecord::Migration
  def change
    create_table :friend_invites do |t|
      t.integer :from
      t.string :from_name
      t.integer :to
      t.string :to_name
      t.datetime :accepted_at
      t.datetime :rejected_at

      t.timestamps
    end
  end
end
