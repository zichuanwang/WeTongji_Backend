# encoding: utf-8
class UserMailer < ActionMailer::Base

  def confirmation(user)
  	@user = user
  	mail(:to => user.email, :subject => "请激活账户.")
  end
  
  def welcome(user)
  	@user = user
  	mail(:to => user.email, :subject => '欢迎来到Wetongji!')
  end

end