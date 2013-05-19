class AddDisplayNameToAdv < ActiveRecord::Migration
  def change
  	add_column :advertisements, :publisher, :string
  end
end
