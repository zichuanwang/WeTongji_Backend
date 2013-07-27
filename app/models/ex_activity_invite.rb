class ExActivityInvite
	attr_accessor :Id, :From, :To, :SentAt, :AcceptedAt, :RejectedAt, :UserDetails, :ActivityDetails, :ToUserDetails

	def self.init_from_activity_invite(activity_invite, user = nil)
		model = ExActivityInvite.new
		
		unless activity_invite.nil?
			model.Id = activity_invite.id
			model.From = activity_invite.from_name
			model.To = activity_invite.to_name
			model.SentAt = activity_invite.created_at
			model.AcceptedAt = activity_invite.accepted_at
			model.RejectedAt = activity_invite.rejected_at
			model.UserDetails = ExUser.init_from_user(activity_invite.from_user, user)
			model.ToUserDetails = ExUser.init_from_user(activity_invite.to_user, user)
			model.ActivityDetails = ExActivity.init_from_activity(activity_invite.activity, user)
		end

		model
	end
end