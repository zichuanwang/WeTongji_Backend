class CreateArounds < ActiveRecord::Migration
  def change
    create_table :arounds do |t|
      t.string :title
      t.string :source
      t.string :summary
      t.string :context
      t.integer :read
      t.integer :like
      t.integer :favorite
      t.integer :admin_id
      t.string :location
      t.string :contact
      t.string :ticket_service

      t.timestamps
    end
  end
end
