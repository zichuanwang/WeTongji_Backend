module Api
	module BillboardHelper
		def billboard
			if verify_action_params(['U', 'S'])
				user = verify_user_authentication
				if user
					p = params[:P].nil? ? 1 : params[:P].to_i

					items = Story.where("visiable = true").order("id desc").page(p).per(5)

					ex = []
					items.each do |n|
						ex << ExStory.init_from_story(n)
					end
					re = ApiReturn.new("000")
					re.add_data("NextPager", (p < items.num_pages ? p + 1 : 0))
					re.add_data("Stories", ex)
					return_response(re)
				end
			end
		end

		def story_add
			
		end

		def comment_add
			
		end

		def story_get
			
		end
	end
end