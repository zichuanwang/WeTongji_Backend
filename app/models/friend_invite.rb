class FriendInvite < ActiveRecord::Base

	has_one :from_user, :class_name => "User", :foreign_key => "from"
	has_one :to_user, :class_name => "User", :foreign_key => "to"

	def accept
		if accepted_at.nil? && rejected_at.nil?
			self.accepted_at = Time.now

			friend_this = Friend.new
			friend_this.user = self.from_user
			friend_this.other_user = self.to_user
			friend_this.nickname = self.to_user.name

			friend_that = Friend.new
			friend_that.user = self.to_user
			friend_that.other_user = self.from_user
			friend_that.nickname = self.from_user.name

			self.save
			friend_this.save
			friend_that.save
		end
	end

	def reject
		if accepted_at.nil? && rejected_at.nil?
			rejected_at = Time.now
			self.save
		end
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
