module ActivitiesHelper
	def get_day(activity)
		unless activity.begin.nil?
			return activity.begin.strftime("%Y-%m-%d")
		end
	end

	def get_begin_hour(activity)
		unless activity.begin.nil?
			return activity.begin.strftime("%H")
		end
	end

	def get_begin_minute(activity)
		unless activity.begin.nil?
			return activity.begin.strftime("%M")
		end
	end

	def get_end_hour(activity)
		unless activity.end.nil?
			return activity.end.strftime("%H")
		end
	end

	def get_end_minute(activity)
		unless activity.end.nil?
			return activity.end.strftime("%M")
		end
	end

	def get_begin_time(activity)
		unless activity.begin.nil?
			return activity.begin.strftime("%H:%M")
		end
	end

	def get_end_time(activity)
		unless activity.end.nil?
			return activity.end.strftime("%H:%M")
		end
	end
end
