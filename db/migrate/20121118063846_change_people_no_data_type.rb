class ChangePeopleNoDataType < ActiveRecord::Migration
  def up
  	change_column :people, :no, :string
  end

  def down
  	change_column :people, :no, :integer
  end
end
