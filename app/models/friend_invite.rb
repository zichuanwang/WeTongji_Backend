class FriendInvite < ActiveRecord::Base

	has_one :from_user, :class_name => "User", :foreign_key => "from"
	has_one :to_user, :class_name => "User", :foreign_key => "to"

	def accept
		
		
	end

	def reject
		
	end

	def self.invite(from_user, to)
		user = User.find_by_no(to)
		if user.user_profile && user.user_profile.allow_add_friend == true
			invite = FriendInvite.new
			invite.from_user = from_user
			invite.from_name = from_user.name
			invite.to_user = user
			invite.to_name = user.name
			return invite
		end
	end
end
