# encoding: utf-8

Exam.all.each do |ex|
	uno_prefix = ''
	if ex.begin < '2012/03/01'
		uno_prefix = '1201'
	elsif ex.begin < '2012/10/01'
		uno_prefix = '1202'
	elsif ex.begin < '2013/03/01'
		uno_prefix = '1301'
	elsif ex.created_at < '2012/07/01'
		uno_prefix = '1201'
	elsif ex.created_at < '2012/12/31'
		uno_prefix = '1202'
	elsif ex.created_at < '2013/07/01'
		uno_prefix = '1301'
	end

	ex.course_uno = uno_prefix + ex.course_uno
	ex.save
	p "exam uno " + ex.course_uno + " done!"
end