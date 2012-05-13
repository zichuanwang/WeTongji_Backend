class ApiController < ApplicationController
	# need split to some partal files
	def test
		return_response ApiReturn.new("000")
	end

	METHODS = {
		"Channels.Get" => "channels",
		"Channel.Fovorite" => "channel_favorite",
		"Channel.UnFavorite" => "channel_unfavorite",

		"Activities.Get" => "activities",
		"Activity.Favorite" => "activity_favorite",
		"Activity.UnFavorite" => "activity_unfavorite",
		"Activity.Like" => "activity_like",
		"Activity.UnLike" => "activity_unlike",
		"Activity.Schedule" => "activity_schedule",
		"Activity.UnSchedule" => "activity_unschedule",

		"Schedule.Get" => "schedule",
		"News.GetList" => "news_getlist",
		"News.Get" => "news_get",
		"User.Active" => "user_active",
		"User.LogOn" => "user_logon",
		"User.LogOff" => "user_logoff",
		"User.Get" => "user_get",
		"User.Update" => "user_update",
		"User.Update.Avatar" => "user_update_avatar",
		"User.Update.Password" => "user_update_password",
	}

	def call
		# check params check sum
		if verify_checksum
      # check params exists system require params
      if verify_sys_params && METHODS[params[:M]]
      	send METHODS[params[:M]]
      else
      	return_response ApiReturn.new("004")
      end
    else
    	return_response ApiReturn.new("001")
    end
  end

  private

  def verify_checksum
  	h = params[:H]
		md5_string = request.query_string.split('&').sort.collect do |s|
  		key, val = s.split('=')
  		unless key == "H"
  			key + "=" + val
  		end
		end
  	# md5_string = params.sort.collect do |s|
  	# 	unless s[0] == "action" || s[0] == "H" || s[0] == "controller"
  	# 		s[0] + "=" + s[1]
  	# 	end
  	# end
  	p Digest::MD5.hexdigest(md5_string.compact.join("&"))
  	p md5_string.compact.join("&")
  	Digest::MD5.hexdigest(md5_string.compact.join("&")) == h
  end

  def verify_sys_params
  	if params[:M] && params[:H] && params[:D] && params[:V]
  		true
  	else
  		false
  	end
  end

  def return_response(api_return)
  	respond_to do |format|
  		format.html { render json: api_return }
  		format.json { render json: api_return }
  	end
  end

	# verify user log
	def verify_action_params(keys = [])
		keys.each do |key|
			if params[key] == nil || params[key] == ''
				return_response ApiReturn.new("007")
				return false
			end
		end
		return true
	end

	# verify for action require user logon
	def verify_user_authentication
		user = User.get_authentication_user(params[:U], params[:S])
		if user
			return user
		else
			re = ApiReturn.new("005")
			return_response(re)
			return nil
		end
	end

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

	# activity operate
	def activities
		channel_ids = params[:Channel_Ids]
		sort = params[:Sort]
		p = params[:P]
		uid = params[:UID]

		activities = Activity
		if uid
			user = User.find_by_uid(uid)
			if user
				activities = user.activities
			end
		end
		if channel_ids
			activities = activities.where(:channel_id => channel_ids.split(','))
		end
		if sort
			activities = activities.order(sort)
		else
			activities = activities.order("id desc")
		end
		if p
			p = p.to_i
			activities = activities.limit(20).offset((p - 1) * 20)
		else
			activities = activities.limit(20)
		end

		ex = []
		activities.each do |activity|
			ex << ExActivity.init_from_activity(activity)
		end
		re = ApiReturn.new("000")
		re.add_data("Activities", ex)
		return_response(re)
	end

	def activity_favorite
		if verify_action_params(['Id', 'UID'])
			activity = Activity.find(params[:Id])
			if activity
				activity.user_favorite(params[:UID])
				activity.save
			end
			re = ApiReturn.new("000")
			return_response(re)
		end
	end

	def activity_unfavorite
		if verify_action_params(['Id', 'UID'])
			activity = Activity.find(params[:Id])
			if activity
				activity.user_unfavorite(params[:UID])
				activity.save
			end
			re = ApiReturn.new("000")
			return_response(re)
		end
	end

	def	activity_like
		if verify_action_params(['Id', 'UID'])
			activity = Activity.find(params[:Id])
			if activity
				activity.user_like(params[:UID])
				activity.save
			end
			re = ApiReturn.new("000")
			return_response(re)
		end
	end

	def	activity_unlike
		if verify_action_params(['Id', 'UID'])
			activity = Activity.find(params[:Id])
			if activity
				activity.user_unlike(params[:UID])
				activity.save
			end
			re = ApiReturn.new("000")
			return_response(re)
		end
	end

	def activity_schedule
		if verify_action_params(['Id', 'UID'])
			activity = Activity.find(params[:Id])
			if activity
				activity.add_to_schedule(params[:UID])
				activity.save
			end
			re = ApiReturn.new("000")
			return_response(re)
		end
	end

	def activity_unschedule
		if verify_action_params(['Id', 'UID'])
			activity = Activity.find(params[:Id])
			if activity
				activity.remove_from_schedule(params[:UID])
				activity.save
			end
			re = ApiReturn.new("000")
			return_response(re)
		end
	end

	def schedule
		if verify_action_params(['UID'])
			user = User.find_by_uid(params[:UID])
			events = []
			activities = []
			if user
				if params[:Begin] && params[:End]
					evnets = user.events.where("begin < :begin && end > :end", :begin => params[:Begin], :end => params[:End])
					activities = user.activities.where("begin < :begin && end > :end", :begin => params[:Begin], :end => params[:End])
				else
					evnets = user.events.where("begin < :begin && end > :end", :begin => Time.now.day - 1, :end => Time.now.day + 1)
					activities = user.activities.where("begin < :begin && end > :end", :begin => Time.now.day - 1, :end => Time.now.day + 1)
				end
			end
			ev = []
			events.each do |event|
				ev << ExEvent.init_from_event(event)
			end
			ac = []
			activities.each do |activity|
				ac << ExActivity.init_from_activity(activity)
			end
			re = ApiReturn.new("000")
			re.add_data("Events", ev)
			re.add_data("Activities", ac)
			return_response(re)
		end
	end

	# news
	def news_getlist
		sort = params[:Sort]
		p = params[:P]

		news = News
		if sort
			news = news.order(sort)
		else
			news = news.order("id desc")
		end
		if p
			p = p.to_i
			news = news.limit(20).offset((p - 1) * 20)
		else
			news = news.limit(20)
		end

		ex = []
		news.each do |n|
			ex << ExNews.init_from_news(n)
		end
		re = ApiReturn.new("000")
		re.add_data("News", ex)
		return_response(re)
	end

	def news_get
		if verify_action_params(['Id'])
			news = News.find(params[:Id])
			ex = nil
			if news
				ex = ExNews.init_from_news(news)
			end
			re = ApiReturn.new("000")
			re.add_data("News", ex)
			return_response(re)
		end
	end

	def user_active
		if verify_action_params(['NO', 'Name', 'Password'])
			if User.is_password_valid?(params[:Password])
				user = User.active_user_from_student(params[:NO], params[:Name], params[:Password])
				if user
					user.save
					re = ApiReturn.new("000")
					return_response(re)
				else
					re = ApiReturn.new("003")
					return_response(re)
				end
			else
				re = ApiReturn.new("010")
				return_response(re)
			end
		end
	end

	def user_logon
		if verify_action_params(['NO', 'Password'])
			user = User.authentication(params[:NO], params[:Password])
			if user
				user.save
				ex = ExUser.init_from_user(user.reload)
				re = ApiReturn.new("000")
				re.add_data("User", ex)
				re.add_data("Session", user.authentication_token)
				return_response(re)
			else
				re = ApiReturn.new("002")
				return_response(re)
			end
		end
	end

	def user_logoff
		if verify_action_params(['U', 'S'])
			user = verify_user_authentication
			user.logoff(params[:U], params[:NO])
			user.save
			re = ApiReturn.new("000")
			return_response(re)
		end
	end

	def user_get
		if verify_action_params(['U', 'S'])
			user = verify_user_authentication
			if user
				ex = ExUser.init_from_user(user.reload)
				re = ApiReturn.new("000")
				re.add_data("User", ex)
				return_response(re)
			end
		end
	end

	# only update displayname now
	def user_update
		if verify_action_params(['U', 'S', 'User'])
			user = verify_user_authentication
			if user
				ExUser.update_json_to_user(JSON.parse(params[:User]), user)
				user.save
				ex = ExUser.init_from_user(user.reload)
				re = ApiReturn.new("000")
				re.add_data("User", ex)
				return_response(re)
			end
		end
	end

	def user_update_avatar
		if verify_action_params(['U', 'S', 'Image'])
			user = verify_user_authentication
			if user
				user.avatar = params[:Image]
				user.save
				ex = ExUser.init_from_user(user.reload)
				re = ApiReturn.new("000")
				re.add_data("User", ex)
				return_response(re)
			end
		end
	end

	def user_update_password
		if verify_action_params(['U', 'S', 'Old', 'New'])
			if User.is_password_valid?(params[:New])
				user = verify_user_authentication
				if user
					user.update_password(params[:Old], params[:New])
					user.save
					ex = ExUser.init_from_user(user.reload)
					re = ApiReturn.new("000")
					re.add_data("User", ex)
					return_response(re)
				end
			else
				re = ApiReturn.new("010")
				return_response(re)
			end
		end
	end
end
