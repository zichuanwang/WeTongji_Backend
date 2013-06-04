class ExCourseInvite
	attr_accessor :Id, :From, :To, :SentAt, :AcceptedAt, :RejectedAt, :UserDetails, :CourseDetails

	def self.init_from_course_invite(course_invite)
		model = ExCourseInvite.new
		model.Id = course_invite.id
		model.From = course_invite.from_name
		model.To = course_invite.to_name
		model.SentAt = course_invite.created_at
		model.AcceptedAt = course_invite.accepted_at
		model.RejectedAt = course_invite.rejected_at
		model.UserDetails = ExUser.init_from_user(course_invite.from_user, course_invite.to_user)
		model.CourseDetails = ExSeleCourse.init_from_sele_course(course_invite.sele_course)
		model
	end
end