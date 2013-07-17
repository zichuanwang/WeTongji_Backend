class RemoveAdvBgcolor < ActiveRecord::Migration
  def up
  	remove_column :advertisements, :bgcolor
  end

  def down
  	add_column :advertisements, :bgcolor, :string
  end
end
