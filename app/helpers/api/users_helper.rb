include SecureHelper

module Api
	module UsersHelper
		def user_active
			if verify_action_params(['NO', 'Name', 'Password'])
				psw = get_password
				if User.is_password_valid?(psw)
					student = Student.find_by_no(params[:NO])
					if student
						student = Student.find_by_no_and_name(params[:NO], params[:Name])
						if student
							user = User.active_user_from_student(params[:NO], params[:Name], psw)
							if user
								user.save
								re = ApiReturn.new("000")
								return_response(re)
							else
								re = ApiReturn.new("008")
								return_response(re)
							end
						else
							re = ApiReturn.new("009")
							return_response(re)
						end
					else
						re = ApiReturn.new("012")
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
				psw = get_password
				user = User.authentication(params[:NO], psw)
				if user
					user.save
					ex = ExUser.init_from_user(user.reload)
					re = ApiReturn.new("000")
					re.add_data("User", ex)
					re.add_data("Session", user.authentication_token)
					return_response(re)
				else
					user = User.find_by_no(params[:NO])
					if user
						user = User.where("no = :no and confirmed_at is not null", :no => params[:NO]).first
						if user
							re = ApiReturn.new("013")
							return_response(re)
						else
							re = ApiReturn.new("011")
							return_response(re)
						end
					else
						re = ApiReturn.new("014")
						return_response(re)
					end
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
				psw_old = params[:Old]
				if params[:V] == "3.0"
					psw_old = Decrypt(params[:Old])
				end
				psw_new = params[:New]
				if params[:V] == "3.0"
					psw_new = Decrypt(params[:New])
				end
				if User.is_password_valid?(psw_new)
					user = verify_user_authentication
					if user
						user.update_password(psw_old, psw_new)
						user.save
						ex = ExUser.init_from_user(user.reload)
						re = ApiReturn.new("000")
						re.add_data("User", ex)
						re.add_data("Session", user.authentication_token)
						return_response(re)
					end
				else
					re = ApiReturn.new("010")
					return_response(re)
				end
			end
		end

		def user_reset_password
			if verify_action_params(['NO', 'Name'])
			    user = User.find_by_no_and_name(params[:NO], params[:Name])
			    if user
					user.send_reset_password_mail
					user.save
					re = ApiReturn.new("000")
					return_response(re)
			    else
			    	re = ApiReturn.new("009")
					return_response(re)
			    end
			end
		end

		def user_find
			if verify_action_params(['NO', 'Name'])
				user = verify_user_authentication
				if user
					re = ApiReturn.new("000")
					u = User.find_with_no_and_name(params[:NO], params[:Name])
					if u
						ex = ExUser.init_from_user(u)
						re.add_data("User", ex)
					else
						re.add_data("User", nil)
					end
					return_response(re)
				end
			end
		end
	end
end
