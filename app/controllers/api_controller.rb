#require 'rsa'
class ApiController < ApplicationController
	include Api::V1Helper

	def test
		return_response ApiReturn.new("000")
	end

	METHODS = {
		"System.Version" => "version",

		#"Channels.Get" => "channels",
		#"Channel.Fovorite" => "channel_favorite",
		#"Channel.UnFavorite" => "channel_unfavorite",

		"Activities.Get" => "activities",

		# delete at 2.0 api support end
		#"Activity.Favorite" => "activity_favorite",
		#"Activity.UnFavorite" => "activity_unfavorite",
		#"Activity.Like" => "activity_like",
		#"Activity.UnLike" => "activity_unlike",

		"Activity.Schedule" => "activity_schedule",
		"Activity.UnSchedule" => "activity_unschedule",
		"Activity.Invite" => "activity_invite",
		"Activity.Invite.Get" => "activity_invite_get",
		"Activity.Invite.Accept" => "activity_invite_accept",
		"Activity.Invite.Reject" => "activity_invite_reject",

		"Course.Invite" => "course_invite",
		"Course.Invite.Get" => "course_invite_get",
		"Course.Invite.Accept" => "course_invite_accept",
		"Course.Invite.Reject" => "course_invite_reject",
		"Course.Schedule" => "course_schedule",
		"Course.UnSchedule" => "course_unschedule",

		"Favorite.Get" => "favorite",
		"Schedule.Get" => "schedule",

		# delete at 2.0 api support end
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

		"User.Update.Profile" => "user_update_profile",
		"User.Profile" => "profile",

		"Friend.Invite" => "friend_invite",
		"Friend.Invite.Get" => "friend_invite_get",
		"Friend.Invite.Accept" => "friend_invite_accept",
		"Friend.Invite.Reject" => "friend_invite_reject",
		"Friends.Get" => "friends",
		"Friend.Remove" => "friend_remove",
		"Friend.Invites.Get" => "friend_invites",

		"Information.GetList" => "information_getlist",
		"Information.Get" => "information_get",
		"Information.Read" => "information_read",

		# delete at 2.0 api support end
		"Information.Favorite" => "information_favorite",
		"Information.UnFavorite" => "information_unfavorite",
		"Information.Like" => "information_like",
		"Information.UnLike" => "information_unlike",

		"People.Get" => "people",
		"Person.GetLatest" => "person_getlatest",
		"Person.Read" => "person_read",

		# delete at 2.0 api support end
		"Person.Favorite" => "person_favorite",
		"Person.UnFavorite" => "person_unfavorite",
		"Person.Like" => "person_like",
		"Person.UnLike" => "person_unlike",
		
		"Person.Get" => "person_get",

		# delete at 2.0 api support end
		"SchoolNews.GetList" => "school_news_getlist",
		"SchoolNews.Get" => "school_news_get",
		"SchoolNews.Read" => "school_news_read",
		"SchoolNews.Favorite" => "school_news_favorite",
		"SchoolNews.UnFavorite" => "school_news_unfavorite",
		"SchoolNews.Like" => "school_news_like",
		"SchoolNews.UnLike" => "school_news_unlike",

		# delete at 2.0 api support end
		"ClubNews.GetList" => "club_news_getlist",
		"ClubNews.Get" => "club_news_get",
		"ClubNews.Read" => "club_news_read",
		"ClubNews.Favorite" => "club_news_favorite",
		"ClubNews.UnFavorite" => "club_news_unfavorite",
		"ClubNews.Like" => "club_news_like",
		"ClubNews.UnLike" => "club_news_unlike",

		# delete at 2.0 api support end
		"Arounds.Get" => "arounds_get",
		"Around.Get" => "around_get",
		"Around.Read" => "around_read",
		"Around.Favorite" => "around_favorite",
		"Around.UnFavorite" => "around_unfavorite",
		"Around.Like" => "around_like",
		"Around.UnLike" => "around_unlike",

		# delete at 2.0 api support end
		"ForStaffs.Get" => "for_staffs_get",
		"ForStaff.Get" => "for_staff_get",
		"ForStaff.Read" => "for_staff_read",
		"ForStaff.Favorite" => "for_staff_favorite",
		"ForStaff.UnFavorite" => "for_staff_unfavorite",
		"ForStaff.Like" => "for_staff_like",
		"ForStaff.UnLike" => "for_staff_unlike",

		"Billboard.Get" => "billboard",
		"Billboard.Story.Add" => "story_add",
		"Billboard.Story.Get" => "story_get",

		"Comment.Add" => "comment_add",
		"Comments.Get" => "comments_get",

		"Like.Add" => "like_add",
		"Like.Remove" => "like_remove",
		"Like.List" => "like_list",

		"Advertisement.Read" => "advertisement_read",

		"Home" => "home",
		"Search" => "search",

		"Notifications.Get" => "notifications",

		"Report.Add" => "report_add",
		"SchoolYear.Setting" => "school_year_setting"
	}

	def call
	    #check params exists system require params
	    if verify_sys_params && METHODS[params[:M]]
	    	ApiLog.create(:m => params[:M], :u => params[:U], :v => params[:V], :d => params[:D])
	       	send METHODS[params[:M]]
	    else
	      	return_response ApiReturn.new("004")
	    end
	end

end
