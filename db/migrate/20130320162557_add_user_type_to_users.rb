# encoding: utf-8
class AddUserTypeToUsers < ActiveRecord::Migration
  def change
    add_column :users, :user_type, :string, :default => '学生'
  end
end
