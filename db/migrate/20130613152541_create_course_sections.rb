class CreateCourseSections < ActiveRecord::Migration
  def change
    create_table :course_sections do |t|
      t.string :course_no
      t.integer :section_start
      t.integer :section_end
      t.string :week_type
      t.string :week_day
      t.string :location

      t.timestamps
    end
  end
end
