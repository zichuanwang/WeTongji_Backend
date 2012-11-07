module Api
	module ChannelsHelper
		# get all channels
		def channels
		  	channels = Channel.all
		  	ex = []
		  	channels.each do |channel|
		  		ex << ExChannel.init_from_channel(channel)
		  	end
		  	re = ApiReturn.new("000")
		  	re.add_data("Channels", ex)
		  	return_response(re)
		end

	  	def channel_follow
	  		if verify_action_params(['Id', 'UID'])
		  		channel = Channel.find(params[:Id])
		  		if channel
			  		channel.user_follow(params[:UID])
			  		channel.save
			  	end
			  	re = ApiReturn.new("000")
			  	return_response(re)
		  	end
	  	end

	  	def channel_unfollow
		  	if verify_action_params(['Id', 'UID'])
			  	channel = Channel.find(params[:Id])
			  	if channel
			  		channel.user_unfollow(params[:UID])
			  		channel.save
			  	end
			  	re = ApiReturn.new("000")
			  	return_response(re)
			end
	  	end
	end
end