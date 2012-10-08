class TranDataToAdmin < ActiveRecord::Migration
  def up
  	Organizer.all.each do |item|
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
  		reg = OrganizerRegister.find_by_name(item.name)
  		unless reg.nil?
  			item.admin.name = reg.person_in_charge
  			item.admin.title = reg.job_title
  			item.admin.phone = reg.cell
  			item.admin.address = reg.address
  			item.admin.student_no = reg.no
  		end

  		item.admin.save
  	end
  	Organizer.all.each do |item|
  		item.activities.each do |act|
  			act.admin = item.admin
  			act.save
  		end
  	end
  end

  def down
  end
end
