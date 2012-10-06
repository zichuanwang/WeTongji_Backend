class VersionsController < ApplicationController
  load_and_authorize_resource
  def index
    @menu = 'admin'
  end

  def show
    @menu = 'admin'
  end

  def new
    @menu = 'admin'
  end

  def edit
    @menu = 'admin'
  end

  def create
    @menu = 'admin'
    respond_to do |format|
      if @version.save
        format.html { redirect_to @version, notice: 'Version was successfully created.' }
        format.json { render json: @version, status: :created, location: @version }
      else
        format.html { render action: "new" }
        format.json { render json: @version.errors, status: :unprocessable_entity }
      end
    end
  end

  def update
    @menu = 'admin'
    respond_to do |format|
      if @version.update_attributes(params[:version])
        format.html { redirect_to @version, notice: 'Version was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @version.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @menu = 'admin'
    @version.destroy

    respond_to do |format|
      format.html { redirect_to versions_url }
      format.json { head :no_content }
    end
  end
end
