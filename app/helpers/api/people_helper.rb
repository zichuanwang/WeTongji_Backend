module Api
	module PeopleHelper
		def people
			user = get_current_user
			sort = params[:Sort]
			p = params[:P].nil? ? 1 : params[:P].to_i

			people = Person
			if sort
				people = people.order(sort)
			else
				people = people.order("id desc")
			end

			people = people.page(p).per(20)

			ex = []
			people.each do |n|
				ex << ExPerson.init_from_person(n, user)
			end
			re = ApiReturn.new("000")
			re.add_data("NextPager", (p < people.num_pages ? p + 1 : 0))
			re.add_data("People", ex)
			return_response(re)
		end

		def person_get
			person = Person.find_by_id(params[:Id])
			ex = nil
			if person
				person.read = person.read + 1
				person.save
				ex = ExPerson.init_from_person(person, get_current_user)
			end
			re = ApiReturn.new("000")
			re.add_data("Person", ex)
			return_response(re)
		end

		def person_getlatest
			person = Person.order('id desc').first
			ex = nil
			if person
				ex = ExPerson.init_from_person(person, get_current_user)
			end
			re = ApiReturn.new("000")
			re.add_data("Person", ex)
			return_response(re)
		end

		def person_read
			person = Person.order('id desc').first
			ex = nil
			if person
				person.read = person.read + 1
				person.save
				ex = ExPerson.init_from_person(person, get_current_user)
			end
			re = ApiReturn.new("000")
			re.add_data("Person", ex)
			return_response(re)
		end

		def person_favorite
			if verify_action_params(['U', 'S', 'Id'])
				user = verify_user_authentication
				if user
					person = Person.find(params[:Id])
					if person
						person.user_favorite(user)
						person.save
					end
					re = ApiReturn.new("000")
					return_response(re)
				end
			end
		end

		def person_unfavorite
			if verify_action_params(['U', 'S', 'Id'])
				user = verify_user_authentication
				if user
					person = Person.find(params[:Id])
					if person
						person.user_unfavorite(user)
						person.save
					end
					re = ApiReturn.new("000")
					return_response(re)
				end
			end
		end

		# def	person_like
		# 	if verify_action_params(['U', 'S', 'Id'])
		# 		user = verify_user_authentication
		# 		if user
		# 			person = Person.find(params[:Id])
		# 			if person
		# 				person.user_like(user)
		# 				person.save
		# 			end
		# 			re = ApiReturn.new("000")
		# 			return_response(re)
		# 		end
		# 	end
		# end

		# def	person_unlike
		# 	if verify_action_params(['U', 'S', 'Id'])
		# 		user = verify_user_authentication
		# 		if user
		# 			person = Person.find(params[:Id])
		# 			if person
		# 				person.user_unlike(user)
		# 				person.save
		# 			end
		# 			re = ApiReturn.new("000")
		# 			return_response(re)
		# 		end
		# 	end
		# end

		def users_like_same_person
			person = Person.find_by_id(params[:Id])
			ex = []
			if person
				ex = []
				person.users_likes.each do |item|
					ex << ExUser.init_from_user(item)
				end
			end
			re = ApiReturn.new("000")
			re.add_data("Users", ex)
			return_response(re)
		end
	end
end