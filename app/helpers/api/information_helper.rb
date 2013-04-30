# encoding: utf-8
module Api
	module InformationHelper
		# information
		def information_getlist
			sort = params[:Sort]
			p = params[:P].nil? ? 1 : params[:P].to_i
			category_ids = params[:Category_Ids]

			information = Information.where("visiable = true")
			if sort
				information = information.order(sort)
			else
				information = information.order("id desc")
			end

			if category_ids
				hash = { "1" => "校园新闻", "2" => "团体通告", "3" => "周边推荐", "4" => "校务信息" }
				information = information.where(:category => category_ids.split(',').collect{ |x| hash[x] })
			end

			information = information.page(p).per(20)

			ex = []
			information.each do |n|
				ex << ExInformation.init_from_information(n)
			end
			re = ApiReturn.new("000")
			re.add_data("NextPager", (p < information.num_pages ? p + 1 : 0))
			re.add_data("Information", ex)
			return_response(re)
		end

		def information_get
			if verify_action_params(['Id'])
				information = Information.find(params[:Id])
				ex = nil
				if information && information.visiable
					ex = ExInformation.init_from_information(information)
				end
				re = ApiReturn.new("000")
				re.add_data("Information", ex)
				return_response(re)
			end
		end

		def information_read
			if verify_action_params(['Id'])
				information = Information.find(params[:Id])
				if information
					information.read = information.read + 1
					information.save
				end
				re = ApiReturn.new("000")
				return_response(re)
			end
		end

		def information_favorite
			if verify_action_params(['U', 'S', 'Id'])
				user = verify_user_authentication
				if user
					information = Information.find(params[:Id])
					if information
						information.user_favorite(user)
						information.save
					end
					re = ApiReturn.new("000")
					return_response(re)
				end
			end
		end

		def information_unfavorite
			if verify_action_params(['U', 'S', 'Id'])
				user = verify_user_authentication
				if user
					information = Information.find(params[:Id])
					if information
						information.user_unfavorite(user)
						information.save
					end
					re = ApiReturn.new("000")
					return_response(re)
				end
			end
		end

		def	information_like
			if verify_action_params(['U', 'S', 'Id'])
				user = verify_user_authentication
				if user
					information = Information.find(params[:Id])
					if information
						information.user_like(user)
						information.save
					end
					re = ApiReturn.new("000")
					return_response(re)
				end
			end
		end

		def	information_unlike
			if verify_action_params(['U', 'S', 'Id'])
				user = verify_user_authentication
				if user
					information = Information.find(params[:Id])
					if information
						information.user_unlike(user)
						information.save
					end
					re = ApiReturn.new("000")
					return_response(re)
				end
			end
		end

	end
end