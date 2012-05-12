class CreateCourses < ActiveRecord::Migration
  def change
    create_table :courses do |t|
      t.string :no
      t.string :name
      t.string :teacher
      t.decimal :point
      t.string :required
      t.integer :hours

      t.timestamps
    end
  end
end
