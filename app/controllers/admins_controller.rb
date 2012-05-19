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
  end

  def details
  end

  def show
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
        format.json { render json: @admin, status: :created, location: @admin }
      else
        format.html { render action: "new" }
        format.json { render json: @admin.errors, status: :unprocessable_entity }
      end
    end
  end

  def update_password
  end
end
