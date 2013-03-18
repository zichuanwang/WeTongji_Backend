class ExFriend
	attr_accessor :Id, :Name, :NickName

	def self.init_from_friend(friend)
		model = ExFriend.new
		model.Id = friend.id
		model.Name = friend.other_user.name
		model.NickName = friend.nickname
		model
	end
end