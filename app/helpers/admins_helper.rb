# encoding: utf-8
module AdminsHelper
	ROLES = {
		"SuperAdmin" => "超级管理员",
		"FunctionAdmin" => "功能管理员",
		"OrganizerAdmin" => "组织管理员",
		"NewsAdmin" => "新闻管理员",
		"InfoAdmin" => "资讯管理员"
	}
	def role_name(role)
		ROLES[role]
	end
end
