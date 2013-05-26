module Api
	module ReportsHelper
		def report_add
			if verify_action_params(['U', 'S', 'Id', 'Model', 'Reason'])
				user = verify_user_authentication
				if user
					report = Report.new
					report.out_id = params[:Id]
					report.out_model_name = params[:Model]
					report.reason = params[:Reason]
					report.user = user
					report.check
					report.save
					re = ApiReturn.new("000")
					return_response(re)
				end
			end
		end
	end
end
