#require 'rsa'
class ApiController < ApplicationController
	include Api::V1Helper
	# need split to some partal files
	def test
		return_response ApiReturn.new("000")
	end

	METHODS = {
		"System.Version" => "version",

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

		"Favorite.Get" => "favorite",

		"Schedule.Get" => "schedule",

		"News.GetList" => "news_getlist",
		"News.Get" => "news_get",
		"News.Read" => "news_read",

		"Information.GetList" => "information_getlist",
		"Information.Get" => "information_get",
		"Information.Read" => "information_read",

		"TimeTable.Get" => "timetable",

		"User.Active" => "user_active",
		"User.LogOn" => "user_logon",
		"User.LogOff" => "user_logoff",
		"User.Get" => "user_get",
		"User.Update" => "user_update",
		"User.Update.Avatar" => "user_update_avatar",
		"User.Update.Password" => "user_update_password",
		"User.Reset.Password" => "user_reset_password"
	}

	def call
		#check params check sum
		if verify_checksum
	    	#check params exists system require params
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
	  	p Digest::MD5.hexdigest(md5_string.compact.join("&"))
	  	p md5_string.compact.join("&")
	  	Digest::MD5.hexdigest(md5_string.compact.join("&")) == h
	end

end
