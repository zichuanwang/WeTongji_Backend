class AddDescriptionToVersion < ActiveRecord::Migration
  def change
    add_column :versions, :description, :string
  end
end
