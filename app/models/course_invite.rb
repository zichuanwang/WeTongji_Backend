class CourseInvite < ActiveRecord::Base
  	attr_accessible :accepted_at, :sele_course_id, :from, :from_name, :rejected_at, :to, :to_name
	
	belongs_to :from_user, :class_name => "User", :foreign_key => "from"
	belongs_to :to_user, :class_name => "User", :foreign_key => "to"
	belongs_to :sele_course

	def accept
		if accepted_at.nil? && rejected_at.nil?
			self.accepted_at = Time.now
			#add this course to to_user schedule
			self.sele_course.user_schedule(self.to_user)
			self.save
		end
	end

	def reject
		if accepted_at.nil? && rejected_at.nil?
			self.rejected_at = Time.now
			self.save
		end
	end

	def self.invite(from_user, to, sele_course_id)
		user = User.find_by_uid(to)
		invite = CourseInvite.new
		invite.from = from_user.id
		invite.from_name = from_user.name
		invite.to = user.id
		invite.to_name = user.name
		invite.sele_course_id = sele_course_id

		return invite
	end
end
