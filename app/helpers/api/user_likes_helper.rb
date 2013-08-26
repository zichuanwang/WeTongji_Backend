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
					when "Course" 
						m = Course.find_by_uno(params[:Id])
						user_like.out_id = 0
						unless m.nil?
							user_like.out_id = m.id
						end
					end
					user_like.user_id = user.id

					if UserLike.can?(user_like.out_model_name, user_like.out_id, user_like.user_id)
						user_like.save
					end
										
					re = ApiReturn.new("000")

					return_response(re)
				end
			end
		end

		def like_remove
			if verify_action_params(['U', 'S', 'Model', 'Id'])
				user = verify_user_authentication
				if user
					user_like = nil
					case params[:Model]
					when "User"
						user_like = UserLike.joins("left join users u on u.id = user_likes.out_id").where("user_likes.out_model_name = 'User' and u.uid = :id and user_likes.user_id = :user_id", :id => params[:Id], :user_id => user.id).first
					when "Course"
						user_like = UserLike.joins("left join courses c on c.id = user_likes.out_id").where("user_likes.out_model_name = 'Course' and c.uno = :id and user_likes.user_id = :user_id", :id => params[:Id], :user_id => user.id).first
					else
						user_like = UserLike.find_by_out_id_and_out_model_name_and_user_id(params[:Id], params[:Model], user.id)
					end
					
					unless user_like.nil?
						user_like.destroy
					end
					
					re = ApiReturn.new("000")
					return_response(re)
				end
			end
		end

		def like_list
			if verify_action_params(['U', 'S', 'Model'])
				user = verify_user_authentication
				if user
					list = UserLike.order("id desc").where("out_model_name = :name and user_id = :user_id", :name => params[:Model], :user_id => user.id)
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
