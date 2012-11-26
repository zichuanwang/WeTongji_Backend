class AddHasTicketToArounds < ActiveRecord::Migration
  def change
    add_column :arounds, :has_ticket, :boolean, :default => false
  end
end
