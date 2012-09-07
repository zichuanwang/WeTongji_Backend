class AddIsPendingToActivity < ActiveRecord::Migration
  def change
    add_column :activities, :is_pending, :boolean, :default => false
    add_column :activities, :visiable, :boolean, :default => true
    add_column :activities, :pending_reason, :string
    add_column :news, :is_pending, :boolean, :default => false
    add_column :news, :visiable, :boolean, :default => true
    add_column :news, :pending_reason, :string
  end
end
