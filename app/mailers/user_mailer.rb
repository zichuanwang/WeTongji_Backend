# encoding: utf-8
class UserMailer < ActionMailer::Base
  #default :from => "we@tongji.edu.cn"
  default :from => "wetongji2012@gmail.com"

  def confirmation(user)
  	@user = user
  	mail(:to => user.email, :subject => "请激活账户.")
  end
  
  def welcome(user)
  	@user = user
  	mail(:to => user.email, :subject => '欢迎来到Wetongji!')
  end

  def reset_password(user)
  	@user = user
  	mail(:to => user.no + "@tongji.edu.cn", :subject => '重置Wetongji密码!')
  end

end