class ExCourseInvite
	attr_accessor :Id, :From, :To, :SentAt, :AcceptedAt, :RejectedAt, :UserDetails, :CourseDetails, :ToUserDetails

	def self.init_from_course_invite(course_invite, user = nil)
		model = ExCourseInvite.new
		unless course_invite.nil?
			model.Id = course_invite.id
			model.From = course_invite.from_name
			model.To = course_invite.to_name
			model.SentAt = course_invite.created_at
			model.AcceptedAt = course_invite.accepted_at
			model.RejectedAt = course_invite.rejected_at
			model.UserDetails = ExUser.init_from_user(course_invite.from_user, user)
			model.ToUserDetails = ExUser.init_from_user(course_invite.to_user, user)
			model.CourseDetails = ExCourse.init_from_course(Course.find_by_uno(course_invite.course_uno), user)
		end
		model
	end
end