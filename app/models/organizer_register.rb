class OrganizerRegister < ActiveRecord::Base
	validates_presence_of :name, :description, :account, :password, :person_in_charge, :job_title, :cell, :email, :address, :icon
	has_attached_file :icon, :styles => { :medium => "180x180>" }
	paginates_per 15
end
