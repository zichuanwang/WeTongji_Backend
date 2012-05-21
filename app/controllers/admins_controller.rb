class AdminsController < ApplicationController
  before_filter :authenticate_admin!

  def index
    @menu = 'admins'

    @admins = Admin.order("id desc").page(params[:page])

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @admins }
    end
  end

  def edit
    @menu = "admins"
    @admin = Admin.find(params[:id])
  end

  def show
    @menu = 'admins'
    @admin = Admin.find(params[:id])
  end

  def new
    @menu = 'admins'
    @admin = Admin.new
    
    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @admin }
    end
  end

  def create
    @menu = 'admins'
    @admin = Admin.new(params[:admin])
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
    @admin = Admin.find(params[:id])

    respond_to do |format|
      if @admin.update_attributes(params[:admin])
        format.html { redirect_to @admin, notice: 'Admin was successfully updated.' }
      else
        format.html { render action: "edit" }
      end
    end
  end

end
