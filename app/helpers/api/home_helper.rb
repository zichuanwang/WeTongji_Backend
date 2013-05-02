# encoding: utf-8
module Api
	module HomeHelper
		def home
			# banners
			banners = Banner.order("id desc").limit(4)
			ex_banners = []
			banners.each do |n|
				ex_banners << ExBanner.init_from_banner(n)
			end



			re = ApiReturn.new("000")
			re.add_data("Banners", ex_banners)
			return_response(re)
		end
	end
end