class AddNoToOrganizerRegisters < ActiveRecord::Migration
  def change
    add_column :organizer_registers, :no, :string

  end
end
