class ForStaffsController < ApplicationController
  load_and_authorize_resource
  def index
    @for_staffs = @for_staffs.order("id desc").page(params[:page])
  end

  def show
  end

  def new
  end

  def edit
  end

  def approve
    @for_staff = ForStaff.find_by_id(params[:id])
    authorize! :approve, @for_staff
    @for_staff.visiable = true
    @for_staff.is_pending = false
    @for_staff.pending_reason = ""
    @for_staff.save
    redirect_to :action => "index"
  end

  def create
    @for_staff.admin = current_admin
    @for_staff.check

    if params[:images]
      params[:images].each do |image|
        img = ForStaffImage.new
        img.file = image
        @for_staff.for_staff_images << img
      end
    end

    respond_to do |format|
      if @for_staff.save
        format.html { redirect_to @for_staff, notice: 'For Staff was successfully created.' }
      else
        format.html { render action: "new" }
      end
    end
  end

  def update
    if params[:images]
      params[:images].each do |image|
        img = ForStaffImage.new
        img.file = image
        @for_staff.for_staff_images << img
      end
    end

    if params[:delete_images]
      params[:delete_images].each do |image|
        img = ForStaffImage.find(image)
        @for_staff.for_staff_images.delete(img)
      end
    end
    
    respond_to do |format|
      if @for_staff.update_attributes(params[:for_staff])
        @for_staff.check
        @for_staff.save
        format.html { redirect_to @for_staff, notice: 'For Staff was successfully updated.' }
      else
        format.html { render action: "edit" }
      end
    end
  end

  def destroy
    @for_staff.destroy

    respond_to do |format|
      format.html { redirect_to :action => "index" }
    end
  end
end
