# encoding: utf-8
class AroundsController < ApplicationController
  load_and_authorize_resource
  def index
    @arounds = @arounds.where("category = '周边推荐'").order("id desc").page(params[:page])
  end

  def show
  end

  def new
  end

  def edit
  end

  def approve
    @around = Around.find_by_id(params[:id])
    authorize! :approve, @around
    @around.visiable = true
    @around.is_pending = false
    @around.pending_reason = ""
    @around.save
    redirect_to :action => "index"
  end

  def top
    @around = Around.find_by_id(params[:id])
    authorize! :top, @around
    Around.update_all(:top => false)
    @around.top = true
    @around.save
    redirect_to :action => "index"
  end

  def create
    @around.admin = current_admin
    @around.category = "周边推荐"
    @around.check

    if params[:images]
      params[:images].each do |image|
        img = InformationImage.new
        img.file = image
        @around.information_images << img
      end
    end

    respond_to do |format|
      if @around.save
        format.html { redirect_to @around, notice: 'Around was successfully created.' }
      else
        format.html { render action: "new" }
      end
    end
  end

  def update
    if params[:images]
      params[:images].each do |image|
        img = InformationImage.new
        img.file = image
        @around.information_images << img
      end
    end

    if params[:delete_images]
      params[:delete_images].each do |image|
        img = InformationImage.find(image)
        @around.information_images.delete(img)
      end
    end
    
    respond_to do |format|
      if @around.update_attributes(params[:around])
        @around.check
        @around.save
        format.html { redirect_to @around, notice: 'Around was successfully updated.' }
      else
        format.html { render action: "edit" }
      end
    end
  end

  def destroy
    @around.destroy

    respond_to do |format|
      format.html { redirect_to :action => "index" }
    end
  end
end
