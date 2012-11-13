#require 'rsa'
class ApiController < ApplicationController
	include Api::V1Helper

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

		"TimeTable.Get" => "timetable",

		"User.Active" => "user_active",
		"User.LogOn" => "user_logon",
		"User.LogOff" => "user_logoff",
		"User.Get" => "user_get",
		"User.Update" => "user_update",
		"User.Update.Avatar" => "user_update_avatar",
		"User.Update.Password" => "user_update_password",
		"User.Reset.Password" => "user_reset_password",

		"Information.GetList" => "information_getlist",
		"Information.Get" => "information_get",
		"Information.Read" => "information_read",
		"Information.Favorite" => "information_favorite",
		"Information.UnFavorite" => "information_unfavorite",
		"Information.Like" => "information_like",
		"Information.UnLike" => "information_unlike",

		"People.Get" => "people",
		"Person.GetLatest" => "person_getlatest",
		"Person.Read" => "person_read",
		"Person.Favorite" => "person_favorite",
		"Person.UnFavorite" => "person_unfavorite",
		"Person.Like" => "person_like",
		"Person.UnLike" => "person_unlike",

		"SchoolNews.GetList" => "school_news_getlist",
		"SchoolNews.Get" => "school_news_get",
		"SchoolNews.Read" => "school_news_read",
		"SchoolNews.Favorite" => "school_news_favorite",
		"SchoolNews.UnFavorite" => "school_news_unfavorite",
		"SchoolNews.Like" => "school_news_like",
		"SchoolNews.UnLike" => "school_news_unlike",

		"ClubNews.GetList" => "club_news_getlist",
		"ClubNews.Get" => "club_news_get",
		"ClubNews.Read" => "club_news_read",
		"ClubNews.Favorite" => "club_news_favorite",
		"ClubNews.UnFavorite" => "club_news_unfavorite",
		"ClubNews.Like" => "club_news_like",
		"ClubNews.UnLike" => "club_news_unlike",

		"Arounds.Get" => "arounds_get",
		"Around.Get" => "around_get",
		"Around.Read" => "around_read",
		"Around.Favorite" => "around_favorite",
		"Around.UnFavorite" => "around_unfavorite",
		"Around.Like" => "around_like",
		"Around.UnLike" => "around_unlike",

		"ForStaffs.Get" => "for_staffs_get",
		"ForStaff.Get" => "for_staff_get",
		"ForStaff.Read" => "for_staff_read",
		"ForStaff.Favorite" => "for_staff_favorite",
		"ForStaff.UnFavorite" => "for_staff_unfavorite",
		"ForStaff.Like" => "for_staff_like",
		"ForStaff.UnLike" => "for_staff_unlike"
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

end
