module Api
	module PeopleHelper
		def people
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
				ex << ExPerson.init_from_person(n)
			end
			re = ApiReturn.new("000")
			re.add_data("NextPager", (p < people.num_pages ? p + 1 : 0))
			re.add_data("People", ex)
			return_response(re)
		end

		def person_getlatest
			if verify_action_params(['Id'])
				person = Person.find(params[:Id])
				ex = nil
				if person
					person.read = person.read + 1
					person.save
					ex = ExPerson.init_from_person(person)
				end
				re = ApiReturn.new("000")
				re.add_data("Person", ex)
				return_response(re)
			end
		end
	end
end