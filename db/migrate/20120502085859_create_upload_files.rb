class CreateUploadFiles < ActiveRecord::Migration
  def change
    create_table :upload_files do |t|
      t.string :name
      t.string :path
      t.integer :size

      t.timestamps
    end
  end
end
