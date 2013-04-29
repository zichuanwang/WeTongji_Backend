class RenameInformationFkName < ActiveRecord::Migration
  def up
  	remove_column :information, :external_id
  	add_column :information_externals, :information_id, :integer
  end

  def down
  	add_column :information, :external_id, :integer
  	remove_column :information_externals, :information_id
  end
end
