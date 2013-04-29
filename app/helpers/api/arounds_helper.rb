# encoding: utf-8
module Api
	module AroundsHelper
		def arounds_get
			sort = params[:Sort]
			p = params[:P].nil? ? 1 : params[:P].to_i

			arounds = Information.where("category = '周边推荐' and visiable = true")
			if sort
				arounds = arounds.order(sort)
			else
				arounds = arounds.order("id desc")
			end

			arounds = arounds.page(p).per(20)

			ex = []
			arounds.each do |n|
				ex << ExAround.init_from_around(n)
			end
			re = ApiReturn.new("000")
			re.add_data("NextPager", (p < arounds.num_pages ? p + 1 : 0))
			re.add_data("Arounds", ex)
			return_response(re)
		end

		def around_get
			if verify_action_params(['Id'])
				around = Around.find(params[:Id])
				ex = nil
				if around && around.visiable
					ex = ExAround.init_from_around(around)
				end
				re = ApiReturn.new("000")
				re.add_data("Around", ex)
				return_response(re)
			end
		end

		def around_read
			if verify_action_params(['Id'])
				around = Around.find(params[:Id])
				if around
					around.read = around.read + 1
					around.save
				end
				re = ApiReturn.new("000")
				return_response(re)
			end
		end

		def around_favorite
			if verify_action_params(['U', 'S', 'Id'])
				user = verify_user_authentication
				if user
					around = Around.find(params[:Id])
					if around
						around.user_favorite(user)
						around.save
					end
					re = ApiReturn.new("000")
					return_response(re)
				end
			end
		end

		def around_unfavorite
			if verify_action_params(['U', 'S', 'Id'])
				user = verify_user_authentication
				if user
					around = Around.find(params[:Id])
					if around
						around.user_unfavorite(user)
						around.save
					end
					re = ApiReturn.new("000")
					return_response(re)
				end
			end
		end

		def	around_like
			if verify_action_params(['U', 'S', 'Id'])
				user = verify_user_authentication
				if user
					around = Around.find(params[:Id])
					if around
						around.user_like(user)
						around.save
					end
					re = ApiReturn.new("000")
					return_response(re)
				end
			end
		end

		def	around_unlike
			if verify_action_params(['U', 'S', 'Id'])
				user = verify_user_authentication
				if user
					around = Around.find(params[:Id])
					if around
						around.user_unlike(user)
						around.save
					end
					re = ApiReturn.new("000")
					return_response(re)
				end
			end
		end
	end
end