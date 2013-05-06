# encoding: utf-8
module Api
	module SearchHelper
		def search
			if verify_action_params(['Keywords'])
				user = get_current_user
				key = params[:Keywords]

				type = params[:Type]
				re = ApiReturn.new("000")

				if type == "1" || type.nil?
					in1 = Person.order("id desc").where("name like :key or job_title like :key", :key => "%#{key}%").limit(10)
					ex1 = []
					in1.each do |item|
						ex1 << ExPerson.init_from_person(item, user)
					end
					re.add_data("Person", ex1)
				end

				if  type == "2" || type.nil?
					in2 = Admin.order("id desc").where("display like :key or name like :key", :key => "%#{key}%").limit(10)
					ex2 = []
					in2.each do |item|
						ex2 << ExAccount.init_from_account(item, user)
					end
					re.add_data("Accounts", ex2)
				end

				if type == "3" or type.nil?
					in3 = Activity.order("id desc").where("title like :key or location like :key", :key => "%#{key}%").limit(10)
					ex3 = []
					in3.each do |item|
						ex3 << ExActivity.init_from_activity(item, user)
					end
					re.add_data("Activities", ex3)
				end

				if type == "4" or type.nil?
					in4 = Information.order("id desc").where("title like :key", :key => "%#{key}%").limit(10)
					ex4 = []
					in4.each do |item|
						ex4 << ExInformation.init_from_information(item, user)
					end
					re.add_data("Information", ex4)
				end
				
				return_response(re)
			end
		end
	end
end