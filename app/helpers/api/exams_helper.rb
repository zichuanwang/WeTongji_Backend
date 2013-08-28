# encoding: utf-8
module Api
	module ExamsHelper
		def exams
			if verify_action_params(['U', 'S', 'Begin', 'End'])
				user = verify_user_authentication
				if user
					if params[:Begin].to_datetime + 10 >= params[:End].to_datetime
						exams = Schedule.get_exams_by_user(user, params[:Begin], params[:End])
						ex = []
						exams.each do |exam|
							ex << ExExam.init_from_exam_instance(exam)
						end

						re = ApiReturn.new("000")
						re.add_data("Exams", ex)
						return_response(re)
					else
						re = ApiReturn.new("018")
						return_response(re)
					end
				end
			end
		end

		def exam_get
			if verify_action_params(['UNO'])
				exam = Exam.find_by_course_uno(params[:UNO])
				ex = ExExam.init_from_exam_instance(exam)
				re = ApiReturn.new("000")
				re.add_data("Exam", ex)
				return_response(re)
			end
		end
	end
end