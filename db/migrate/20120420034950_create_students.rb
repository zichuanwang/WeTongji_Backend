class CreateStudents < ActiveRecord::Migration
  def change
    create_table :students do |t|
      t.string :name
      t.string :no
      t.string :email

      t.timestamps
    end
  end
end
