class AddColumnsToUsers < ActiveRecord::Migration
  def change
  	add_column :users, :no, :string
  end
end
