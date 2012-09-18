# encoding: utf-8
class AddFakeStudent < ActiveRecord::Migration
  def up
  	Student.create(:no => "000000", :name => "微同济", :gender => "男", :birthday => "2012/07/01", 
  					:department => "软件学院", :major => "软件工程", :year => "2012", :plan => "4", :email => "we@tongji.edu.cn")
  	user = User.active_user_from_student("000000", "微同济", "123456")
	user.confirmed_at = Time.now
	user.confirmation_token = nil
  	user.save
  end

  def down
  	User.delete_all("no = '000000'")
  	Student.delete_all("no = '000000'")
  end
end
