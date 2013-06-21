class CourseInvite < ActiveRecord::Base
  	attr_accessible :accepted_at, :course_uno, :student_no, :from, :from_name, :rejected_at, :to, :to_name
	
	belongs_to :from_user, :class_name => "User", :foreign_key => "from"
	belongs_to :to_user, :class_name => "User", :foreign_key => "to"

	def accept
		if accepted_at.nil? && rejected_at.nil?
			self.accepted_at = Time.now
			self.to_user.audit_courses << Course.find_by_uno(self.course_uno)
			self.save
		end
	end

	def reject
		if accepted_at.nil? && rejected_at.nil?
			self.rejected_at = Time.now
			self.save
		end
	end

	def self.invite(from_user, to, uno)
		user = User.find_by_uid(to)

		unless user.nil?
			invite = CourseInvite.new
			invite.from = from_user.id
			invite.from_name = from_user.name
			invite.to = user.id
			invite.to_name = user.name
			invite.course_uno = uno
			invite.student_no = from_user.no
		end
		
		return invite
	end
end
