module Api
	module NewsHelper
		# news
		def news_getlist
			sort = params[:Sort]
			p = params[:P].nil? ? 1 : params[:P].to_i

			news = News.where("visiable = true")
			if sort
				news = news.order(sort)
			else
				news = news.order("id desc")
			end

			news = news.page(p).per(20)

			ex = []
			news.each do |n|
				ex << ExNews.init_from_news(n)
			end
			re = ApiReturn.new("000")
			re.add_data("NextPager", (p < news.num_pages ? p + 1 : 0))
			re.add_data("News", ex)
			return_response(re)
		end

		def news_get
			if verify_action_params(['Id'])
				news = News.find(params[:Id])
				ex = nil
				if news && news.visiable
					news.read = news.read + 1
					news.save
					ex = ExNews.init_from_news(news)
				end
				re = ApiReturn.new("000")
				re.add_data("News", ex)
				return_response(re)
			end
		end

		def news_read
			if verify_action_params(['Id'])
				news = News.find(params[:Id])
				if news
					news.read = news.read + 1
					news.save
				end
				re = ApiReturn.new("000")
				return_response(re)
			end
		end
	end
end