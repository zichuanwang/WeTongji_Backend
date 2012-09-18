class AddTimeSpanToSeleCourses < ActiveRecord::Migration
  def change
    add_column :sele_courses, :begin, :datetime
    add_column :sele_courses, :end, :datetime
    SeleCourse.update_all("begin = '2012/02/20', end = '2012/07/01'")
  end
end
