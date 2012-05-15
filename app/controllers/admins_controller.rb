class AdminsController < ApplicationController
  before_filter :authenticate_admin!

  def index
    @menu = 'admins'
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
