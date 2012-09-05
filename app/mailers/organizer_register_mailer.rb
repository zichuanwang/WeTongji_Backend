# encoding: utf-8
class OrganizerRegisterMailer < ActionMailer::Base

  default :from => "we@tongji.edu.cn"
  
  def welcome(organizer)
    @organizer = organizer
    mail(:to => organizer.admin.email, :subject => '您的申请已经审批通过!')
  end

end
