class AddColumnToActivity < ActiveRecord::Migration
  def change
  	add_column :activities, :sub_organizer_id, :integer
  end
end
