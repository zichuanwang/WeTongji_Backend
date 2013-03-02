class AddTypeToEvents < ActiveRecord::Migration
  def change
    add_column :events, :type, :string
    add_column :events, :source_id, :integer
    add_column :events, :image, :string
  end
end
