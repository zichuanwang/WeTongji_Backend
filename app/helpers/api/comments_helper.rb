module Api
	module CommentsHelper
		def comment_add
			if verify_action_params(['U', 'S', 'Id', 'Body', 'Model'])
				user = verify_user_authentication
				if user
					comment = Comment.new
					comment.out_id = params[:Id]
					comment.out_model_name = params[:Model]
					comment.body = params[:Body]
					comment.is_anonymous = params[:Anonymous]
					comment.user = user
					comment.check
					comment.save
					re = ApiReturn.new("000")
					return_response(re)
				end
			end
		end

		def comments_get
			if verify_action_params(['U', 'S', 'Id', 'Model'])
				user = verify_user_authentication
				if user
					ex_c = []
						p = params[:P].nil? ? 1 : params[:P].to_i

						coms = Comment.where("visiable = true and out_model_name => :model and out_id = :id", :model => params[:Model]).order("id desc").page(p).per(5)

						coms.each do |item|
							ex_c << ExComment.init_from_comment(item)
						end
					end
					re = ApiReturn.new("000")
					re.add_data("Comments", ex_c)
					re.add_data("NextPager", (p < coms.num_pages ? p + 1 : 0))
					return_response(re)
				end
			end
		end
	end
end