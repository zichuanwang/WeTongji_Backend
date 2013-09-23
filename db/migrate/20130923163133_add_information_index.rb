class AddInformationIndex < ActiveRecord::Migration
	def up
		add_index "information", ["category"], :name => "index_information_on_category", :unique => false
		add_index "information", ["admin_id"], :name => "index_information_on_admin_id", :unique => false
		add_index "activities", ["admin_id"], :name => "index_activities_on_admin_id", :unique => false
		add_index "activities", ["channel_id"], :name => "index_activities_on_channel_id", :unique => false
	end

	def down
		remove_index "information", :name => "index_information_on_category"
		remove_index "information", :name => "index_information_on_admin_id"
		remove_index "activities", :name => "index_activities_on_admin_id"
		remove_index "activities", :name => "index_activities_on_channel_id"
	end
end
