class ApplicationController < ActionController::Base
  protect_from_forgery
  layout :layout_by_resource

  rescue_from CanCan::AccessDenied do |exception|
    flash[:error] = exception.message
    #current_aility.sign_out
    redirect_to new_admin_session_url
  end

  def current_ability
  	@current_ability ||= Ability.new(current_admin)
	end

  def after_sign_out_path_for(resource_or_scope)
    request.referrer
  end

  protected

  def layout_by_resource
    if devise_controller?
      "out"
    else
      "application"
      #"new_schema"
    end
  end
end
