class ApiController < ApplicationController
	
	def test
		return_response ApiReturn.new("000")
	end

	METHODS = {
		"Channels.Get" => "channels",
		"Channel.Follow" => "channel_follow",
		"Channel.UnFollow" => "channel_unfollow",
		"Activities.Get" => "activities",
		"Activity.Follow" => "activity_follow",
		"Activity.UnFollow" => "activity_unfollow",
		"Activity.Like" => "activity_like",
		"Activity.UnLike" => "activity_unlike",
		"Activity.Add" => "activity_add",
		"Activity.Delete" => "activity_delete",
		"Schedule.Get" => "schedule",
		"News.GetList" => "news_getlist",
		"News.Get" => "news_get",
		"User.Active" => "user_active",
		"User.LogOn" => "user_logon",
		"User.LogOff" => "user_logoff",
		"User.Get" => "user_get",
		"User.Update" => "user_update",
		"User.Update.Avatar" => "user_update_avatar",
		"User.Update.Password" => "user_update_password"
	}

	def call
		# check params check sum
    if verify_checksum
      # check params exists system require params
      if verify_sys_params
        case params[:M]
        	# channel and activity
        	when "Channels.Get"
          	channels
        	when "Channel.Follow"
          	channel_follow
        	when "Channel.UnFollow"
          	channel_unfollow
         	when "Activities.Get"
         		activities
          when "Activity.Follow"
          	activity_follow
          when "Activity.UnFollow"
          	activity_unfollow
          when "Activity.Like"
          	activity_like
          when "Activity.UnLike"
          	activity_unlike
          when "Activity.Add"
          	activity_add
          when "Activity.Delete"
          	activity_delete
          # schedule
          when "Schedule.Get"
          	schedule
          # news
          when "News.GetList"
          	news_getlist
          when "News.Get"
          	news_get
          # users
          when "User.Active"
          	user_active
          when "User.LogOn"
          	user_logon
          when "User.LogOff"
          	user_logoff
          when "User.Get"
          	user_get
          when "User.Update"
          	user_update
         	when "User.Update.Avatar"
          	user_update_avatar
          when "User.Update.Password"
          	user_update_password	            		            	
        end
      else
        return_response ApiReturn.new("004")
      end
    else
      return_response ApiReturn.new("001")
    end
	end

	private
	
	def verify_checksum
  	hash = params[:H]
  	md5_string = params.sort.collect do |s|
    		unless s[0] == "action" || s[0] == "H" || s[0] == "controller"
      		s[0] + "=" + s[1]
    		end
  	end
  	p Digest::MD5.hexdigest(md5_string.compact.join("&"))
  	p md5_string.compact.join("&")
  	Digest::MD5.hexdigest(md5_string.compact.join("&")) == hash
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
				return_response ApiReturn.new("001")
			end
		end
	end

	# verify for action require user logon
	def verify_user_authentication
		user = User.verify_authentication(params[:U], params[:S])
		if user
			user
		else
			re = ApiReturn.new("005")
			return_response(re)
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
		verify_action_params(['Id', 'UID'])
		channel = Channel.find(params[:Id])
		if channel
			channel.user_follow(params[:UID])
			channel.save
		end
		re = ApiReturn.new("000")
	    return_response(re)
	end

	def channel_unfollow
		verify_action_params(['Id', 'UID'])
		channel = Channel.find(params[:Id])
		if channel
			channel.user_unfollow(params[:UID])
			channel.save
		end
		re = ApiReturn.new("000")
	    return_response(re)
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

	def activity_follow
		verify_action_params(['Id', 'UID'])
		activity = Activity.find(params[:Id])
		if activity
			activity.user_follow(params[:UID])
			activity.save
		end
		re = ApiReturn.new("000")
	    return_response(re)
	end

	def activity_unfollow
		verify_action_params(['Id', 'UID'])
		activity = Activity.find(params[:Id])
		if activity
			activity.user_unfollow(params[:UID])
			activity.save
		end
		re = ApiReturn.new("000")
	  return_response(re)
	end

	def	activity_like
		verify_action_params(['Id', 'UID'])
		activity = Activity.find(params[:Id])
		if activity
			activity.user_like(params[:UID])
			activity.save
		end
		re = ApiReturn.new("000")
	  return_response(re)
	end

	def	activity_unlike
		verify_action_params(['Id', 'UID'])
		activity = Activity.find(params[:Id])
		if activity
			activity.user_unlike(params[:UID])
			activity.save
		end
		re = ApiReturn.new("000")
	  return_response(re)
	end

	def activity_add
		verify_action_params(['Id', 'UID'])
		activity = Activity.find(params[:Id])
		if activity
			activity.add_to_schedule(params[:UID])
			activity.save
		end
		re = ApiReturn.new("000")
	  return_response(re)
	end

	def activity_delete
		verify_action_params(['Id', 'UID'])
		activity = Activity.find(params[:Id])
		if activity
			activity.remove_from_schedule(params[:UID])
			activity.save
		end
		re = ApiReturn.new("000")
	  return_response(re)
	end

	def schedule
		verify_action_params(['UID'])
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
		verify_action_params(['Id'])
		news = News.find(params[:Id])
		ex = nil
		if news
			ex = ExNews.init_from_news(news)
		end
		re = ApiReturn.new("000")
		re.add_data("News", ex)
	  return_response(re)
	end

	def user_active
		verify_action_params(['NO', 'Name', 'Password'])
		user = User.active_user_from_student(params[:NO], params[:Name], params[:Password])
		if user
			user.save
			re = ApiReturn.new("000")
			return_response(re)
		else
			re = ApiReturn.new("002")
			return_response(re)
		end
	end

	def user_logon
		verify_action_params(['NO', 'Password'])
		user = User.authentication(params[:NO], params[:Password])
		if user
			ex = ExUser.init_from_user(user)
			re = ApiReturn.new("000")
			re.add_data("User", ex)
			re.add_data("Session", user.authentication_token)
	  	return_response(re)
		else
			re = ApiReturn.new("002")
			return_response(re)
		end
	end

	def user_logoff
		verify_action_params(['U', 'S'])
		verify_user_authentication
		User.logoff(params[:U], params[:NO])
		re = ApiReturn.new("000")
		return_response(re)
	end
end
