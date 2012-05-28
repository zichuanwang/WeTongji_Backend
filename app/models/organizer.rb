class Organizer < ActiveRecord::Base
	has_many :activities
	has_one :admin

	has_attached_file :icon, :styles => { :medium => "300x300>", :thumb => "100x100>" }
end
