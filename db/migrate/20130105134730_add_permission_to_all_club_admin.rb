class AddPermissionToAllClubAdmin < ActiveRecord::Migration
  def up
  	Admin.where("role = 'CommonAdmin'").each do |admin|
  		p = Permission.new
  		p.flag = "ClubNews"
  		admin.permissions << p
  		admin.save
  	end

  end

  def down
  	
  end
end
