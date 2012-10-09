# encoding: utf-8
class AdminMailer < ActionMailer::Base

  default :from => "we@tongji.edu.cn"
  
  def welcome(admin)
    mail(:to => admin.email, :subject => '您的申请已经审批通过!')
  end

end
