class ExFriend
	attr_accessor :Id, :Name, :NickName

	def self.init_from_friend(friend)
		model = ExFriend.new
		model.Id = friend_invite.id
		model.From = friend_invite.from
		model.FromName = friend_invite.from_name
		model.To = friend_invite.to
		model.ToName = friend_invite.to_name
		model.SendAt = friend_invite.created_at
		model.AcceptedAt = friend_invite.accepted_at
		model.RejectedAt = friend_invite.rejected_at
		model
	end
end