module Api
	module SystemProfileHelper
		def version
			version = Version.where("current = :current", :current => params[:D]).first
			ex = nil
			if version
				ex = ExVersion.init_from_version(version)
			end
			re = ApiReturn.new("000")
			re.add_data("Version", ex)
			return_response(re)
		end
	end
end