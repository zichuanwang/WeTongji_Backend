class AddColumnToActivity < ActiveRecord::Migration
  def change
  	add_column :activities, :operator_id, :integer
  end
end
