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
			if verify_action_params(['U', 'S', 'Title'])
				user = verify_user_authentication
				if user
					story = Story.new
					story.title = params[:Title]
					story.body = params[:Body]
					story.image = params[:Image]
					story.user = user
					story.check
					story.save

					re = ApiReturn.new("000")

					return_response(re)
				end
			end
		end

		def comment_add
			if verify_action_params(['U', 'S', 'Id', 'Body'])
				user = verify_user_authentication
				if user
					story = Story.find(params[:Id])
					if story && story.visiable
						comment = StoryComment.new
						comment.body = params[:Body]
						comment.user = user
						comment.story = story
						comment.check
						comment.save
					end
					re = ApiReturn.new("000")

					return_response(re)
				end
			end
		end

		def story_get
			if verify_action_params(['U', 'S', 'Id'])
				user = verify_user_authentication
				if user
					story = Story.find(params[:Id])
					ex = nil
					ex_c = []
					if story && story.visiable
						ex = ExStory.init_from_story(story)
						story.story_comments.each do |item|
							ex_c << ExStoryComment.init_from_story_comment(item)
						end
					end
					re = ApiReturn.new("000")
					re.add_data("Story", ex)
					re.add_data("StoryComments", ex_c)
					return_response(re)
				end
			end
		end
	end
end