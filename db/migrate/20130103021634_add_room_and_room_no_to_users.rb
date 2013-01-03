class AddRoomAndRoomNoToUsers < ActiveRecord::Migration
  def change
    add_column :users, :room, :string

    add_column :users, :room_no, :string

  end
end
