# encoding: utf-8
require 'action_view'
include ActionView::Helpers::DateHelper

def get_uno(base_uno, uno, teacher, week_day, week_type, section_start, section_end)
	# 逻辑:
	# 1,找到当前uno是否有course记录
	# 1.1,如果没有,直接用这个号
	# 1.2,如果有,老师名字一样,要看看这个老师是否一致
	# 1.2.1,如果老师名字一致,看看这个老师的当前section set是不是含有这个section
	# 1.2.2,如果没有,老师名字不一样,直接加个0


	# 因为有可能是课号存在,但是老师不一致,所以不能连课号和老师一起判断
	c = Course.find_by_uno(uno)
	if c.nil?
		return uno
	else
		if c.teacher == teacher

			# 如果一条都没有,说明是空的,可以用这个
			if c.course_sections.count == 0
				return uno
			else
				s = c.course_sections.find_by_course_uno_and_week_type_and_week_day_and_section_start_and_section_end(uno, week_type, week_day, section_start, section_end)
				if s.nil?
					return get_uno(base_uno, "#{uno}0", teacher, week_day, week_type, section_start, section_end)
				else
					return uno
				end
			end
		else
			# 课号无用,转下一个
			return get_uno(base_uno, "#{uno}0", teacher, week_day, week_type, section_start, section_end)
		end
	end
end

def copy_from(base_uno, uno, teacher)
	c = Course.find_by_uno(base_uno)
	unless c.nil?
		if Course.find_by_uno(uno).nil?
			c_new = Course.new
			c_new.no = c.no
			c_new.name = c.name
			c_new.point = c.point
			c_new.hours = c.hours
			c_new.required = c.required
			c_new.begin = c.begin
			c_new.end = c.end
			c_new.uno = uno
			c_new.teacher = teacher
			c_new.save

			p "copy from #{base_uno} to #{uno} with teacher #{teacher}"
		end
	end
end

def take_course(course_uno, student_no)
	if CourseTake.find_by_course_uno_and_student_no(course_uno, student_no).nil?
		t = CourseTake.new
		t.student_no = student_no
		t.course_uno = course_uno
		t.save

		p "save take course #{t.course_uno} with #{t.student_no}"
	end
end

p Rails.root
b = Time.now

#看每一个学生的set
SeleCourse.where("created_at > '2013-09-01'").select("distinct student_no").each do |curr_no|
	p "current process #{curr_no['student_no']}"
	SeleCourse.where("created_at > '2013-09-01' and student_no = :student_no", :student_no => curr_no['student_no']).select("distinct course_no, teacher").each do |course_no|
		p "current course is #{course_no['course_no']}"
		all = SeleCourse.where("created_at > '2013-09-01' and student_no = :student_no and course_no = :course_no and teacher = :teacher", :student_no => curr_no['student_no'], :course_no => course_no['course_no'], :teacher => course_no['teacher'])
		if all.length > 0
			new_uno = get_uno("1302#{all[0].course_no}", "1302#{all[0].course_no}", all[0].teacher, all[0].week_day, all[0].week_type, all[0].section_start, all[0].section_end)
			all.each do |row|
				s = CourseSection.new
				s.course_uno = new_uno
				s.section_start = row.section_start
				s.section_end = row.section_end
				s.week_type = row.week_type
				s.week_day = row.week_day
				s.location = row.location

				unless CourseSection.where(:course_uno => s.course_uno, :section_start => s.section_start, :section_end => s.section_end, :week_day => s.week_day, :week_type => s.week_type, :location => s.location).exists?
					s.save
				end

				copy_from("1302#{course_no['course_no']}", s.course_uno, course_no['teacher'])
				take_course(s.course_uno, curr_no['student_no'])

			end
		end
	end
end

e = Time.now
p "import task done in #{distance_of_time_in_words(b, e, true)}"
