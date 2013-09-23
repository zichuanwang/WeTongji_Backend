class AddIndexForCourseInviteFunction < ActiveRecord::Migration
	def up
		add_index "course_invites", ["from"], :name => "index_course_invites_on_from", :unique => false
		add_index "course_invites", ["to"], :name => "index_course_invites_on_to", :unique => false
		add_index "course_invites", ["from", "to"], :name => "index_course_invites_on_from_to", :unique => false
		add_index "friend_invites", ["from"], :name => "index_friend_invites_on_from", :unique => false
		add_index "friend_invites", ["to"], :name => "index_friend_invites_on_to", :unique => false
		add_index "friend_invites", ["from", "to"], :name => "index_friend_invites_on_from_to", :unique => false
		add_index "activity_invites", ["from"], :name => "index_activity_invites_on_from", :unique => false
		add_index "activity_invites", ["to"], :name => "index_activity_invites_on_to", :unique => false
		add_index "activity_invites", ["from", "to"], :name => "index_activity_invites_on_from_to", :unique => false
		add_index "notifications", ["out_model_name"], :name => "index_notifications_on_out_model_name", :unique => false
		add_index "notifications", ["out_id"], :name => "index_notifications_on_out_id", :unique => false
		add_index "notifications", ["out_model_name", "out_id"], :name => "index_notifications_on_out_model_name_out_id", :unique => false
	end

	def down
		remove_index "course_invites", :name => "index_course_invites_on_from"
		remove_index "course_invites", :name => "index_course_invites_on_to"
		remove_index "course_invites", :name => "index_course_invites_on_from_to"
		remove_index "friend_invites", :name => "index_friend_invites_on_from"
		remove_index "friend_invites", :name => "index_friend_invites_on_to"
		remove_index "friend_invites", :name => "index_friend_invites_on_from_to"
		remove_index "activity_invites", :name => "index_activity_invites_on_from"
		remove_index "activity_invites", :name => "index_activity_invites_on_to"
		remove_index "activity_invites", :name => "index_activity_invites_on_from_to"
		remove_index "notifications", :name => "index_notifications_on_out_model_name"
		remove_index "notifications", :name => "index_notifications_on_out_id"
		remove_index "notifications", :name => "index_notifications_on_out_model_name_out_id"
	end
end
