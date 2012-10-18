class Drop2012AutumnCourseSelect < ActiveRecord::Migration
  def up
  	SeleCourse.delete_all("begin > '2012/09/01'")
  end

  def down
  end
end
