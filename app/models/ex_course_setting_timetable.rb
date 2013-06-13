# encoding: utf-8
class ExCourseSettingTimetable
	attr_accessor :SectionStart, :SectionEnd, :WeekType, :WeekDay, :Location

	def self.init_from_course_setting_timetable(timetable)
		ex = ExCourseSettingTimetable.new

		unless timetable.nil?
			ex.SectionEnd = timetable.section_end
			ex.SectionStart = timetable.section_start
			ex.WeekDay = timetable.week_day
			ex.WeekType = timetable.week_type
			ex.Location = timetable.location
		end

		ex
	end
end