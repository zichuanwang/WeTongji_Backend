# encoding: utf-8
module Api
	module SchoolNewsHelper
		def school_news_getlist
			sort = params[:Sort]
			p = params[:P].nil? ? 1 : params[:P].to_i

			school_news = SchoolNews.where("category = '校园新闻' and visiable = true")
			if sort
				school_news = school_news.order(sort)
			else
				school_news = school_news.order("id desc")
			end

			school_news = school_news.page(p).per(20)

			ex = []
			school_news.each do |n|
				ex << ExSchoolNews.init_from_school_news(n)
			end
			re = ApiReturn.new("000")
			re.add_data("NextPager", (p < school_news.num_pages ? p + 1 : 0))
			re.add_data("SchoolNews", ex)
			return_response(re)
		end

		def school_news_get
			if verify_action_params(['Id'])
				school_news = SchoolNews.find(params[:Id])
				ex = nil
				if school_news && school_news.visiable
					ex = ExSchoolNews.init_from_school_news(school_news)
				end
				re = ApiReturn.new("000")
				re.add_data("SchoolNews", ex)
				return_response(re)
			end
		end

		def school_news_read
			if verify_action_params(['Id'])
				school_news = SchoolNews.find(params[:Id])
				if school_news
					school_news.read = school_news.read + 1
					school_news.save
				end
				re = ApiReturn.new("000")
				return_response(re)
			end
		end

		def school_news_favorite
			if verify_action_params(['U', 'S', 'Id'])
				user = verify_user_authentication
				if user
					school_news = SchoolNews.find(params[:Id])
					if school_news
						school_news.user_favorite(user)
						school_news.save
					end
					re = ApiReturn.new("000")
					return_response(re)
				end
			end
		end

		def school_news_unfavorite
			if verify_action_params(['U', 'S', 'Id'])
				user = verify_user_authentication
				if user
					school_news = SchoolNews.find(params[:Id])
					if school_news
						school_news.user_unfavorite(user)
						school_news.save
					end
					re = ApiReturn.new("000")
					return_response(re)
				end
			end
		end

		def	school_news_like
			if verify_action_params(['U', 'S', 'Id'])
				user = verify_user_authentication
				if user
					school_news = SchoolNews.find(params[:Id])
					if school_news
						school_news.user_like(user)
						school_news.save
					end
					re = ApiReturn.new("000")
					return_response(re)
				end
			end
		end

		def	school_news_unlike
			if verify_action_params(['U', 'S', 'Id'])
				user = verify_user_authentication
				if user
					school_news = SchoolNews.find(params[:Id])
					if school_news
						school_news.user_unlike(user)
						school_news.save
					end
					re = ApiReturn.new("000")
					return_response(re)
				end
			end
		end

	end
end