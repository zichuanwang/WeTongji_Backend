module Api
	module InformationHelper
		# information
		def information_getlist
			sort = params[:Sort]
			p = params[:P].nil? ? 1 : params[:P].to_i

			information = Information.where("visiable = true")
			if sort
				information = information.order(sort)
			else
				information = information.order("id desc")
			end

			information = information.page(p).per(20)

			ex = []
			information.each do |n|
				ex << ExInformation.init_from_information(n)
			end
			re = ApiReturn.new("000")
			re.add_data("NextPager", (p < information.num_pages ? p + 1 : 0))
			re.add_data("Information", ex)
			return_response(re)
		end

		def information_get
			if verify_action_params(['Id'])
				information = Information.find(params[:Id])
				ex = nil
				if information && information.visiable
					information.read = information.read + 1
					information.save
					ex = ExInformation.init_from_information(information)
				end
				re = ApiReturn.new("000")
				re.add_data("Information", ex)
				return_response(re)
			end
		end

		def information_read
			if verify_action_params(['Id'])
				information = Information.find(params[:Id])
				if information
					information.read = information.read + 1
					information.save
				end
				re = ApiReturn.new("000")
				return_response(re)
			end
		end
	end
end