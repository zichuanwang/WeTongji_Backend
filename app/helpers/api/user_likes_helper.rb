module Api
	module UserLikesHelper
		def like_add
			if verify_action_params(['U', 'S', 'Model', 'Id'])
				user = verify_user_authentication
				if user
					user_like = UserLike.new
					user_like.out_id = params[:Id]
					user_like.out_model_name = params[:Model]
					case user_like.out_model_name
					when "User"
						m = User.find_by_uid(params[:Id])
						user_like.out_id = 0
						unless m.nil?
							user_like.out_id = m.id
						end
					end
					user_like.user_id = user.id
					user_like.save
					
					re = ApiReturn.new("000")

					return_response(re)
				end
			end
		end

		def like_remove
			if verify_action_params(['U', 'S', 'Model', 'Id'])
				user = verify_user_authentication
				if user
					user_like = UserLike.find_by_out_id_and_out_model_name(params[:Id], params[:Model])
					
					if user.user_likes.exists?(user_like)
						user.user_likes.delete(user_like)
						user.save
					end
					
					re = ApiReturn.new("000")
					return_response(re)
				end
			end
		end

		def like_list
			if verify_action_params(['U', 'S'])
				user = verify_user_authentication
				if user
					list = user.user_likes
					p = params[:P].nil? ? 1 : params[:P].to_i
					list = list.page(p).per(20)
					ex = []
					list.each do |l|
						ex << ExLike.init_from_like(l, user)
					end

					re = ApiReturn.new("000")
					re.add_data("NextPager", (p < list.num_pages ? p + 1 : 0))
					re.add_data("Like", ex)

					return_response(re)
				end
			end
		end
	end
end