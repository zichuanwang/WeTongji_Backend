class AdminsController < ApplicationController
  load_and_authorize_resource
  def index
    @menu = 'admins'

    @admins = @admins.order("id desc").page(params[:page])
  end

  def edit
    @menu = "admins"
  end

  def show
    @menu = 'admins'
  end

  def new
    @menu = 'admins'
  end

  def create
    @menu = 'admins'
    respond_to do |format|
      if @admin.save
        format.html { redirect_to @admin, notice: 'Admin was successfully created.' }
      else
        format.html { render action: "edit" }
      end
    end
  end

  def update
    @menu = 'admins'
    params[:admin].delete(:password) if params[:admin][:password].blank?
    params[:admin].delete(:password_confirmation) if params[:admin][:password].blank? and params[:admin][:password_confirmation].blank?

    respond_to do |format|
      if @admin.update_attributes(params[:admin])
        format.html { redirect_to @admin, notice: 'Admin was successfully updated.' }
      else
        format.html { render action: "edit" }
      end
    end
  end

end
