class Organizer < ActiveRecord::Base
	has_many :activities
	has_one :admin

	has_attached_file :icon, :styles => { :medium => "200x200>", :thumb => "100x100>" }

	# before_save :randomize_file_name

	# private
	# def randomize_file_name
 #    	extension = File.extname(icon_file_name).downcase  
 #    	self.icon.instance_write(:file_name, "#{Time.now.strftime("%Y%m%d%H%M%S")}#{rand(1000)}#{extension}")
	# end
end
