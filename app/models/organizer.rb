class Organizer < ActiveRecord::Base
	has_many :activities
	has_many :sub_organizers

	#has_attached_file :avatar, :styles => { :medium => "300x300>", :thumb => "100x100>" }
end
