class ApplicationController < ActionController::Base
  protect_from_forgery
  layout :layout_by_resource

  rescue_from CanCan::AccessDenied do |exception|
    flash[:error] = exception.message
    #current_aility.sign_out
    p exception.message
    redirect_to new_admin_session_url
  end

  def current_ability
  	@current_ability ||= Ability.new(current_admin)
	end

  protected

  def layout_by_resource
    if devise_controller?
      "out"
    else
      case action_name
      when "index" then "list"
      when "show" then "form"
      when "edit" then "form"
      when "new" then "form"
      else "application" end
    end
  end
end
