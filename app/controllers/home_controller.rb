class HomeController < ApplicationController
	#load_and_authorize_resource
	before_filter :authenticate_admin!
  def index
  end
end
