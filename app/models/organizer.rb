class Organizer < ActiveRecord::Base
	has_many :activities
	has_many :sub_organizers
end
