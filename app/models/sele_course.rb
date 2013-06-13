require 'csv'
class SeleCourse < ActiveRecord::Base
	validates_presence_of :course_no, :student_no, :location, :teacher, :week_type, :week_day, :section_start, :section_end
	paginates_per 20
  has_and_belongs_to_many :users_schedules, :class_name => "User", :join_table => "sele_courses_users_schedules"

	def self.import(file_path)
		courses = []

		csv_text = File.read(file_path)
		csv = CSV.parse(csv_text, :headers => true)
		csv.each do |row|
			s = SeleCourse.new
			s.student_no = row[0]
  		s.course_no = row[1]
  		s.teacher = row[2]
  		s.week_type = row[3]
  		s.week_day = row[4]
  		s.section_start = row[5]
  		s.section_end = row[6]
  		s.location = row[7]
  		s.begin = row[8]
  		s.end = row[9]
  		courses << s
		end

  		courses
  end

  def user_schedule(user)
    if user && !self.users_schedules.exists?(user)
      self.users_schedules << user
    end
  end

  def user_unschedule(user)
    if user && self.users_schedules.exists?(user)
      self.users_schedules.delete(user)
    end
  end

  def self.get_timetable(student_no, course_no)
    setting = CourseSetting.new
    setting.no = course_no
    c = Course.find_by_no(course_no)
    if c
      setting.hours = c.hours
      setting.point = c.point
      setting.required = c.required
      setting.name = c.name
      setting.teacher = c.teacher
    end
    setting.timetable = []

    list = SeleCourse.where("student_no = :s_no and course_no = :c_no", :s_no => student_no, :c_no => course_no)

    list.each do |item|
      tb = CourseSettingTimeTable.new
      tb.section_start = item.section_start
      tb.section_end = item.section_end
      tb.week_day = item.week_day
      tb.week_type = item.week_type
      tb.location = item.location
      setting.timetable << tb
    end
    
    setting
  end

end