class ActivityInvite < ActiveRecord::Base
  	attr_accessible :accepted_at, :from, :from_name, :rejected_at, :to, :to_name, :activity_id

	belongs_to :from_user, :class_name => "User", :foreign_key => "from"
	belongs_to :to_user, :class_name => "User", :foreign_key => "to"
	belongs_to :activity

	def accept
		if accepted_at.nil? && rejected_at.nil?
			#Friend.connect(self.from_user.id, self.to_user.id)
			self.accepted_at = Time.now
			#add this activity to to_user schedule
			self.activity.user_schedule(self.to_user)
			self.save
		end
	end

	def reject
		if accepted_at.nil? && rejected_at.nil?
			self.rejected_at = Time.now
			self.save
		end
	end

	def self.invite(from_user, to, activity_id)
		user = User.find_by_uid(to)
		invite = ActivityInvite.new
		invite.from = from_user.id
		invite.from_name = from_user.name
		invite.to = user.id
		invite.to_name = user.name
		invite.activity_id = activity_id

		return invite
	end
end
