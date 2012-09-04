class OrganizerRegister < ActiveRecord::Base
	has_attached_file :icon, :styles => { :medium => "180x180>" }
end
