# encoding: utf-8
module AdminsHelper
	ROLES = {
		"SuperAdmin" => "超级管理员",
		"CommonAdmin" => "普通管理员"
	}
	def role_name(role)
		ROLES[role]
	end

	def roles
		ROLES
	end
end
