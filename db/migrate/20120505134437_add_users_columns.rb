class AddUsersColumns < ActiveRecord::Migration
  def up
  	add_column :users, :major, :string
    add_column :users, :native_place, :string
    add_column :users, :degree, :string
    add_column :users, :gender, :string
    add_column :users, :year, :string
    add_column :users, :birthday, :datetime
    add_column :users, :plan, :string
    add_column :users, :sina_weibo, :string
    add_column :users, :qq, :string
    add_column :users, :department, :string
    rename_column :students, :navtiveplace, :native_place
  end

  def down  	
  	remove_column :users, :major
    remove_column :users, :native_place
    remove_column :users, :degree
    remove_column :users, :gender
    remove_column :users, :year
    remove_column :users, :birthday
    remove_column :users, :plan
    remove_column :users, :sina_weibo
    remove_column :users, :qq
    remove_column :users, :department
    rename_column :students, :native_place, :navtiveplace
  end
end
