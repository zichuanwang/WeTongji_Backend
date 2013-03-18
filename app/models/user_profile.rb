class UserProfile < ActiveRecord::Base
	belongs_to :user

	def init_default_setting
		self.can_be_found = true
        self.allow_add_friend = true
        self.public_schedule = true
        self.public_schedule_to_all = false
        self.public_information = true
        self.public_information_to_all = false
	end
end
