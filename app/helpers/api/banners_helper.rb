# encoding: utf-8
module Api
	module BannersHelper
		def banners_get
			banners = Banner.order("id desc").limit(3)

			ex = []
			banners.each do |n|
				ex << ExBanner.init_from_banner(n)
			end
			re = ApiReturn.new("000")
			re.add_data("Banners", ex)
			return_response(re)
		end

		def banner_read
			if verify_action_params(['Id'])
				banner = Banner.find(params[:Id])
				if banner
					banner.read = banner.read + 1
					banner.save
				end
				re = ApiReturn.new("000")
				return_response(re)
			end
		end
	end
end