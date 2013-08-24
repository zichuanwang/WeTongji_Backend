#require 'rsa'
class ApiController < ApplicationController
	include Api::V1Helper

	def test
		return_response ApiReturn.new("000")
	end

	METHODS = {
		"System.Version" => "version",

		"Activities.Get" => "activities",
		"Activities.Get.ByUser" => "activities_get_by_user",
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
		"Courses.Get.ByUser" => "courses_get_by_user",

		"Favorite.Get" => "favorite",
		"Schedule.Get" => "schedule",

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
		"Friends.Get.WithSameCourse" => "friends_with_same_course",
		"Friends.Get.WithSameActivity" => "friends_with_same_activity",
		"Friends.Get.WithSameFriend" => "friends_with_same_friend",
		"Friends.Get.ByUser" => "friends_get_by_user",
		"Friend.Get" => "friend_get",

		"Information.GetList" => "information_getlist",
		"Information.Get" => "information_get",
		"Information.Read" => "information_read",

		"People.Get" => "people",
		"Person.GetLatest" => "person_getlatest",
		"Person.Read" => "person_read",
		"Person.Get" => "person_get",
		"Users.Like.SamePerson" => "users_like_same_person",

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
		"SchoolYear.Setting" => "school_year_setting",

		"Account.Get" => "account_get",

		"Exams.Get" => "exams",
		"Exam.Get" => "exam_get",
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
