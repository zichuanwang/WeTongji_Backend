class ChangePeopleNoDataType < ActiveRecord::Migration
  def up
  	change_column :people, :no, :string
  	add_column :people, :student_no, :string
  end

  def down
  	change_column :people, :no, :integer
  	remove_column :people, :student_no, :string
  end
end
