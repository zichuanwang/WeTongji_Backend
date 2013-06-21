# encoding: utf-8

# second, generate course scetion
SeleCourse.select("course_no, begin, end, location, week_type, week_day, section_start, section_end").group("course_no, begin, end, location, week_type, week_day, section_start, section_end").each do |s|
	uno_prefix = ''
	if s["begin"] < '2012/03/01'
		uno_prefix = '1201'
	elsif s["begin"] < '2012/10/01'
		uno_prefix = '1202'
	elsif s["begin"] < '2013/03/01'
		uno_prefix = '1301'
	end
	section = CourseSection.new
	section.location = s["location"]
	section.week_type = s["week_type"]
	section.course_uno = uno_prefix + s["course_no"].to_s
	section.week_day = s["week_day"]
	section.section_start = s["section_start"]
	section.section_end = s["section_end"]
	section.save
	p "section for " + section.course_uno
end

p "section generate done!"