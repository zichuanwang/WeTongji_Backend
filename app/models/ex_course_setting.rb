# encoding: utf-8
class ExCourseSetting
	attr_accessor :NO, :Name, :Teacher, :Hours, :Timetable, :Point, :Required

	def self.init_from_course_setting(setting)
		ex = ExCourseSetting.new

		unless setting.nil?
			ex.NO = setting.no
			ex.Name = setting.name
			ex.Teacher = setting.teacher
			ex.Hours = setting.hours
			ex.Point = setting.point
			ex.Required = setting.required
			ex.Timetable = []

			setting.Timetable.each do |item|
				setting.Timetable << ExCourseSettingTimeTable.init_from_course_setting_timetable(item)
			end
		end

		ex
	end
end