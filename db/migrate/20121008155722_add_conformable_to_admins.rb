class AddConformableToAdmins < ActiveRecord::Migration
  def change
    add_column :admins, :confirmation_token, :string
    add_column :admins, :confirmed_at, :datetime
    add_column :admins, :confirmation_sent_at, :datetime
    add_column :admins, :unconfirmed_email, :string # Only if using reconfirmable
    add_index :admins, :confirmation_token, :unique => true
    # User.reset_column_information # Need for some types of updates, but not for update_all.
    # To avoid a short time window between running the migration and updating all existing
    # admins as confirmed, do the following
    Admin.update_all(:confirmed_at => Time.now)
    # All existing user accounts should be able to log in after this.
    add_column :admins, :approved_at, :datetime
    Admin.update_all(:approved_at => Time.now)
  end
end
