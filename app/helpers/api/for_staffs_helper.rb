# encoding: utf-8
module Api
	module ForStaffsHelper
		def for_staffs_get
			sort = params[:Sort]
			p = params[:P].nil? ? 1 : params[:P].to_i

			for_staffs = ForStaff.where("category = '校务信息' and visiable = true")
			if sort
				for_staffs = for_staffs.order(sort)
			else
				for_staffs = for_staffs.order("id desc")
			end

			for_staffs = for_staffs.page(p).per(20)

			ex = []
			for_staffs.each do |n|
				ex << ExForStaff.init_from_for_staff(n)
			end
			re = ApiReturn.new("000")
			re.add_data("NextPager", (p < for_staffs.num_pages ? p + 1 : 0))
			re.add_data("ForStaffs", ex)
			return_response(re)
		end

		def for_staff_get
			if verify_action_params(['Id'])
				for_staff = ForStaff.find(params[:Id])
				ex = nil
				if for_staff && for_staff.visiable
					ex = ExForStaff.init_from_for_staff(for_staff)
				end
				re = ApiReturn.new("000")
				re.add_data("ForStaff", ex)
				return_response(re)
			end
		end

		def for_staff_read
			if verify_action_params(['Id'])
				for_staff = ForStaff.find(params[:Id])
				if for_staff
					for_staff.read = for_staff.read + 1
					for_staff.save
				end
				re = ApiReturn.new("000")
				return_response(re)
			end
		end

		def for_staff_favorite
			if verify_action_params(['U', 'S', 'Id'])
				user = verify_user_authentication
				if user
					for_staff = ForStaff.find(params[:Id])
					if for_staff
						for_staff.user_favorite(user)
						for_staff.save
					end
					re = ApiReturn.new("000")
					return_response(re)
				end
			end
		end

		def for_staff_unfavorite
			if verify_action_params(['U', 'S', 'Id'])
				user = verify_user_authentication
				if user
					for_staff = ForStaff.find(params[:Id])
					if for_staff
						for_staff.user_unfavorite(user)
						for_staff.save
					end
					re = ApiReturn.new("000")
					return_response(re)
				end
			end
		end

		def	for_staff_like
			if verify_action_params(['U', 'S', 'Id'])
				user = verify_user_authentication
				if user
					for_staff = ForStaff.find(params[:Id])
					if for_staff
						for_staff.user_like(user)
						for_staff.save
					end
					re = ApiReturn.new("000")
					return_response(re)
				end
			end
		end

		def	for_staff_unlike
			if verify_action_params(['U', 'S', 'Id'])
				user = verify_user_authentication
				if user
					for_staff = ForStaff.find(params[:Id])
					if for_staff
						for_staff.user_unlike(user)
						for_staff.save
					end
					re = ApiReturn.new("000")
					return_response(re)
				end
			end
		end

	end
end