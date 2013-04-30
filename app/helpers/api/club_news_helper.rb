# encoding: utf-8
module Api
	module ClubNewsHelper
		def club_news_getlist
			sort = params[:Sort]
			p = params[:P].nil? ? 1 : params[:P].to_i

			club_news = ClubNews.where("category = '社团通告' and visiable = true")
			if sort
				club_news = club_news.order(sort)
			else
				club_news = club_news.order("id desc")
			end

			club_news = club_news.page(p).per(20)

			ex = []
			club_news.each do |n|
				ex << ExClubNews.init_from_club_news(n)
			end
			re = ApiReturn.new("000")
			re.add_data("NextPager", (p < club_news.num_pages ? p + 1 : 0))
			re.add_data("ClubNews", ex)
			return_response(re)
		end

		def club_news_get
			if verify_action_params(['Id'])
				club_news = ClubNews.find(params[:Id])
				ex = nil
				if club_news && club_news.visiable
					ex = ExClubNews.init_from_club_news(club_news)
				end
				re = ApiReturn.new("000")
				re.add_data("ClubNews", ex)
				return_response(re)
			end
		end

		def club_news_read
			if verify_action_params(['Id'])
				club_news = ClubNews.find(params[:Id])
				if club_news
					club_news.read = club_news.read + 1
					club_news.save
				end
				re = ApiReturn.new("000")
				return_response(re)
			end
		end

		def club_news_favorite
			if verify_action_params(['U', 'S', 'Id'])
				user = verify_user_authentication
				if user
					club_news = ClubNews.find(params[:Id])
					if club_news
						club_news.user_favorite(user)
						club_news.save
					end
					re = ApiReturn.new("000")
					return_response(re)
				end
			end
		end

		def club_news_unfavorite
			if verify_action_params(['U', 'S', 'Id'])
				user = verify_user_authentication
				if user
					club_news = ClubNews.find(params[:Id])
					if club_news
						club_news.user_unfavorite(user)
						club_news.save
					end
					re = ApiReturn.new("000")
					return_response(re)
				end
			end
		end

		def	club_news_like
			if verify_action_params(['U', 'S', 'Id'])
				user = verify_user_authentication
				if user
					club_news = ClubNews.find(params[:Id])
					if club_news
						club_news.user_like(user)
						club_news.save
					end
					re = ApiReturn.new("000")
					return_response(re)
				end
			end
		end

		def	club_news_unlike
			if verify_action_params(['U', 'S', 'Id'])
				user = verify_user_authentication
				if user
					club_news = ClubNews.find(params[:Id])
					if club_news
						club_news.user_unlike(user)
						club_news.save
					end
					re = ApiReturn.new("000")
					return_response(re)
				end
			end
		end
	end
end