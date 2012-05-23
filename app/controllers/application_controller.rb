class ApplicationController < ActionController::Base
  protect_from_forgery

  rescue_from CanCan::AccessDenied do |exception|
    flash[:error] = exception.message
    #current_aility.sign_out
    p exception.message
    redirect_to new_admin_session_url
  end

  def current_ability
  	@current_ability ||= Ability.new(current_admin)
	end
end
