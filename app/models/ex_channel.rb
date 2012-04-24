class ExChannel
	attr_accessor :Id, :Title, :Image, :Follow, :Description

	def self.init_from_channel(channel)
		@Id = channel.id
		@Title = channel.title
		#@Image = channel.image
		@Follow = channel.follow
		@Description = channel.description
	end
end