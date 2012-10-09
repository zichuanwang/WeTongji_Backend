class TranDataToAdmin < ActiveRecord::Migration
  def up
  	Organizer.all.each do |item|
		begin
			item.admin.display = item.name
			item.admin.name = item.name
			item.admin.address = item.name + "waiting for input"
			item.admin.title = item.name + "waiting for input"
			item.admin.phone = item.name + "waiting for input"
			item.admin.student_no = item.name + "waiting for input"
			item.admin.description = item.description
			item.admin.icon = item.icon
			item.admin.role = "CommonAdmin"
			item.admin.save
  		rescue Exception => e
  			p e
  			p item
  			p item.admin
  		end
  	end

  	Organizer.all.each do |item|
  		item.activities.each do |act|
  			act.admin = item.admin
  			act.save
  		end
  	end

	OrganizerRegister.all.each do |item|
		admin = Admin.find_by_email(item.account)
		unless admin.nil?
			admin.name = item.person_in_charge
			admin.title = item.job_title
			admin.phone = item.cell
			admin.address = item.address
			admin.save
		end
	end

	News.update_all(:admin_id => 2)
  end

  def down
  end
end
