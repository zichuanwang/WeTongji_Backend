class FriendInvite < ActiveRecord::Base
	belongs_to :from_user, :class_name => "User", :foreign_key => "from"
	belongs_to :to_user, :class_name => "User", :foreign_key => "to"

	def accept
		if accepted_at.nil? && rejected_at.nil?
			Friend.connect(self.from_user.id, self.to_user.id)
			self.accepted_at = Time.now
			self.save
		end
	end

	def reject
		if accepted_at.nil? && rejected_at.nil?
			self.rejected_at = Time.now
			self.save
		end
	end

	def self.invite(from_user, to)
		user = User.find_by_uid(to)
		if user.user_profile && user.user_profile.allow_add_friend == true

			invite = FriendInvite.new
			invite.from = from_user.id
			invite.from_name = from_user.name
			invite.to = user.id
			invite.to_name = user.name

			return invite
		end
	end
end
