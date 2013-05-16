# encoding: utf-8
module Api
	module AdvertisementsHelper
		def advertisement_read
			if verify_action_params(['Id'])
				ad = Advertisement.find(params[:Id])
				if ad
					ad.read = ad.read + 1
					ad.save
				end
				re = ApiReturn.new("000")
				return_response(re)
			end
		end
	end
end