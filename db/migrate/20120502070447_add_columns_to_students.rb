class AddColumnsToStudents < ActiveRecord::Migration
  def change
  	add_column :students, :department, :string
  	add_column :students, :plan, :string
  	add_column :students, :gender, :string
  	add_column :students, :year, :string
  end
end