# encoding: utf-8
class UsersController < ApplicationController
	before_filter :authenticate_admin!, :except => [:confirmation, :welcome, :reset_password, :reset_password_success, :reset_password_from_mail]
  def index
    @users = User.accessible_by(current_ability).order('id desc')
    if (params[:type] == "unconfirmed")
      @users = @users.where("confirmed_at is null")
    end
    unless params[:no].blank?
      @users = @users.where("no = :no", :no => params[:no])
    end
    unless params[:name].blank?
      @users = @users.where("name = :name", :name => params[:name])
    end
    @users = @users.page(params[:page])
    @menu = "users"
  end

  def reconfirm
    user = User.find(params[:id])
    if user
      UserMailer.confirmation(user).deliver
    end
    redirect_to :action => "index"
  end

  def batch_save
    case params[:status]
      when "重新发送激活邮件"
        unless params[:selected_ids].nil?
          users = User.where("confirmed_at is null and id in (:ids)", :ids => params[:selected_ids]).order("id desc")
          users.each do |user|
            UserMailer.confirmation(user).deliver
          end
        end
      when "批量激活"
        unless params[:selected_ids].nil?
          users = User.where("confirmed_at is null and id in (:ids)", :ids => params[:selected_ids]).order("id desc")
          users.each do |user|
            user.confirmed_at = Time.now
            user.save
            UserMailer.welcome(user).deliver
          end
        end
    end 

    redirect_to users_path
  end

  def reconfirm_all
    users = User.where("confirmed_at is null").order("id desc")
    users.each do |user|
      UserMailer.confirmation(user).deliver
    end
    redirect_to :action => "index"
  end

  def send_reset_password_mail
    user = User.find(params[:id])
    if user
      user.send_reset_password_mail
      user.save
    end
    redirect_to :action => "index"
  end

  def reset_password_from_mail
    unless params[:token].nil?
      @user = User.find_by_reset_password_token(params[:token])
    end
    render :layout => "out"
  end

  def reset_password
    @user = User.find_by_reset_password_token(params[:token])
    if params[:password] == params[:password_confirmation] && User.is_password_valid?(params[:password]) && @user
        @user.password = params[:password]
        @user.reset_password_token = ''
        @user.save
        redirect_to users_reset_password_success_url
    else
      redirect_to users_reset_password_from_mail_url(:token => params[:token])
    end
  end

  def reset_password_success
    render :layout => "out"
  end

  def confirmation
  	user = User.find_by_confirmation_token(params[:token])
  	if user && user.confirmed_at == nil
  		user.confirmed_at = Time.now
  		user.save
  		UserMailer.welcome(user).deliver
  		redirect_to :action => "welcome"
  	else
  		render :layout => "out"
  	end
  end

  def welcome
  	render :layout => "out"
  end
end
