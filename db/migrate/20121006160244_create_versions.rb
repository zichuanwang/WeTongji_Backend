class CreateVersions < ActiveRecord::Migration
  def change
    create_table :versions do |t|
      t.string :current
      t.string :latest
      t.string :url

      t.timestamps
    end
  end
end
