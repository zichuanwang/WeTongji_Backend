class CreateOrganizerRegisters < ActiveRecord::Migration
  def change
    create_table :organizer_registers do |t|
      t.string :name
      t.string :description
      t.string :account
      t.string :password
      t.string :person_in_charge
      t.string :job_title
      t.string :cell
      t.string :email
      t.string :address
      t.datetime :approved_at
      t.string :icon_file_name
      t.string :icon_content_type
      t.integer :icon_file_size
      t.datetime :icon_updated_at
      t.timestamps
    end
  end
end
