class UsersController < ApplicationController
	before_filter :authenticate_admin!

    def index
    @users = User.all
    @menu = "users"

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @users }
    end

    def reconfirm

    	redirect_to users_path
    end

  def destroy
    @user = User.find(params[:id])
    @user.destroy

    respond_to do |format|
      format.html { redirect_to users_path }
      format.json { head :no_content }
    end
  end

  end
end