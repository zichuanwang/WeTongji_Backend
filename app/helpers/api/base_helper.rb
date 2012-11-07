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
end