class AddUserTypeToUsers < ActiveRecord::Migration
  def change
    add_column :users, :type, :string, :default => '1'
  end
end
