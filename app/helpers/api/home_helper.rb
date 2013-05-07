# encoding: utf-8
module Api
	module HomeHelper
		def home
			# banners
			user = get_current_user

			banners = Banner.order("id desc").limit(4)
			ex_banners = []
			banners.each do |n|
				ex_banners << ExBanner.init_from_banner(n)
			end

			# information
			info = Information.find_by_sql("select * from information where id in (select id from (select max(id) as id from information group by category) as tb)")
			ex_information = []
			info.each do |i|
				ex_information << ExInformation.init_from_information(i, user)
			end

			# feature
			person = Person.order('id desc').first
			ex_person = nil
			if person
				ex_person = ExPerson.init_from_person(person, user)
			end

			# activity
			activities = Activity.find_by_sql("select * from activities where id in (select id from (select max(id) as id from activities group by channel_id) as tb)")
			ex_activities = []
			activities.each do |a|
				ex_activities << ExActivity.init_from_activity(a, user)
			end

			# account
			account_new = Admin.order('id desc').where("sign_in_count > 0 and role = 'CommonAdmin'").first
			account_pop = Admin.order('information_count desc').where("sign_in_count > 0 and role = 'CommonAdmin'").first

			re = ApiReturn.new("000")
			re.add_data("Banners", ex_banners)
			re.add_data("Information", ex_information)
			re.add_data("Person", ex_person)
			re.add_data("Activities", ex_activities)
			re.add_data("AccountPopulor", ExAccount.init_from_account(account_pop, user))
			re.add_data("AccountNewest", ExAccount.init_from_account(account_new, user))
			return_response(re)
		end
	end
end