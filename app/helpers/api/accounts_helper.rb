module Api
	module AccountsHelper
		def account_get
			if verify_action_params(['Id'])
				acc = Admin.find_by_id(params[:Id])
				ex = nil
				unless acc.nil?
					ex = ExAccount.init_from_account(acc, get_current_user)
				end
				re = ApiReturn.new("000")
				re.add_data("Account", ex)
				return_response(re)
			end
		end
	end
end