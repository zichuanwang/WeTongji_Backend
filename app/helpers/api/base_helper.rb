module Api
	module BaseHelper
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
					return_response ApiReturn.new("007")
					return false
				end
			end
			return true
		end

		# verify for action require user logon
		def verify_user_authentication
			user = User.get_authentication_user(params[:U], params[:S])
			if user
				return user
			else
				re = ApiReturn.new("005")
				return_response(re)
				return nil
			end
		end
	end
end