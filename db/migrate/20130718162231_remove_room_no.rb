class RemoveRoomNo < ActiveRecord::Migration
  def up
  	remove_column :users, :room_no
  end

  def down
  	add_column :users, :room_no, :string
  end
end
