class ExFriendInvite
	attr_accessor :Id, :From, :To, :SentAt, :AcceptedAt, :RejectedAt, :UserDetails

	def self.init_from_friend_invite(friend_invite)
		model = ExFriendInvite.new
		model.Id = friend_invite.id
		model.From = friend_invite.from_name
		model.To = friend_invite.to_name
		model.SentAt = friend_invite.created_at
		model.AcceptedAt = friend_invite.accepted_at
		model.RejectedAt = friend_invite.rejected_at
		model.UserDetails = ExUser.init_from_user(friend_invite.from_user, friend_invite.to_user)
		model
	end
end