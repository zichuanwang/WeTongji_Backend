class ForStaffsController < ApplicationController
  # GET /for_staffs
  # GET /for_staffs.json
  def index
    @for_staffs = ForStaff.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @for_staffs }
    end
  end

  # GET /for_staffs/1
  # GET /for_staffs/1.json
  def show
    @for_staff = ForStaff.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @for_staff }
    end
  end

  # GET /for_staffs/new
  # GET /for_staffs/new.json
  def new
    @for_staff = ForStaff.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @for_staff }
    end
  end

  # GET /for_staffs/1/edit
  def edit
    @for_staff = ForStaff.find(params[:id])
  end

  # POST /for_staffs
  # POST /for_staffs.json
  def create
    @for_staff = ForStaff.new(params[:for_staff])

    respond_to do |format|
      if @for_staff.save
        format.html { redirect_to @for_staff, notice: 'For staff was successfully created.' }
        format.json { render json: @for_staff, status: :created, location: @for_staff }
      else
        format.html { render action: "new" }
        format.json { render json: @for_staff.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /for_staffs/1
  # PUT /for_staffs/1.json
  def update
    @for_staff = ForStaff.find(params[:id])

    respond_to do |format|
      if @for_staff.update_attributes(params[:for_staff])
        format.html { redirect_to @for_staff, notice: 'For staff was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @for_staff.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /for_staffs/1
  # DELETE /for_staffs/1.json
  def destroy
    @for_staff = ForStaff.find(params[:id])
    @for_staff.destroy

    respond_to do |format|
      format.html { redirect_to for_staffs_url }
      format.json { head :no_content }
    end
  end
end
