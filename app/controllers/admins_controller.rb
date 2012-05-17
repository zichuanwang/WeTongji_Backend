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
  end
end
