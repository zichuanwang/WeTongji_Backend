# encoding: utf-8
class ExCourseSection
	attr_accessor :SectionStart, :SectionEnd, :WeekType, :WeekDay, :Location

	def self.init_from_course_section(section)
		ex = ExCourseSection.new

		unless section.nil?
			ex.SectionEnd = section.section_end
			ex.SectionStart = section.section_start
			ex.WeekDay = section.week_day
			ex.WeekType = section.week_type
			ex.Location = section.location
		end

		ex
	end
end