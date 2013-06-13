class ExCourseInvite
	attr_accessor :Id, :From, :To, :SentAt, :AcceptedAt, :RejectedAt, :UserDetails, :CourseDetails

	def self.init_from_course_invite(course_invite)
		model = ExCourseInvite.new
		unless course_invite.nil?
			model.Id = course_invite.id
			model.From = course_invite.from_name
			model.To = course_invite.to_name
			model.SentAt = course_invite.created_at
			model.AcceptedAt = course_invite.accepted_at
			model.RejectedAt = course_invite.rejected_at
			model.UserDetails = ExUser.init_from_user(course_invite.from_user, course_invite.to_user)
			model.CourseDetails = ExCourseSetting.init_from_course_setting(SeleCourse.get_timetable(course_invite.student_no, course_invite.course_no))
		end
		model
	end
end