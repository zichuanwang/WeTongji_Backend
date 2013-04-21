class CreateInformationExternals < ActiveRecord::Migration
  def change
    create_table :information_externals do |t|
      t.string :source
      t.string :summary
      t.string :tags
      t.boolean :has_ticket
      t.string :ticket_service
      t.string :location
      t.string :contact
      t.string :image_file_name
      t.string :image_content_type
      t.integer :image_file_size
      t.datetime :image_updated_at

      t.timestamps
    end
  end
end
