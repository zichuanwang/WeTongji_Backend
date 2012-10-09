class AddLockableToAdmins < ActiveRecord::Migration
  def change
  	add_column :admins, :failed_attempts, :integer, :default => 0
  	add_column :admins, :unlock_token, :string
  	add_column :admins, :locked_at, :datetime
  end
end
