class InformationController < ApplicationController
  load_and_authorize_resource
  def index
    @menu = 'information'
    @information = @information.order("id desc").page(params[:page])
  end

  def show
    @menu = 'information'
  end

  def new
    @menu = 'information'
  end

  def edit
    @menu = 'information'
  end

  def approve
    @information = information.find_by_id(params[:id])
    authorize! :approve, @information
    @information.visiable = true
    @information.is_pending = false
    @information.pending_reason = ""
    @information.save
    redirect_to :action => "index"
  end

  def create
    @information = Information.new(params[:information])

    respond_to do |format|
      if @information.save
        format.html { redirect_to @information, notice: 'Information was successfully created.' }
        format.json { render json: @information, status: :created, location: @information }
      else
        format.html { render action: "new" }
        format.json { render json: @information.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /information/1
  # PUT /information/1.json
  def update
    @information = Information.find(params[:id])

    respond_to do |format|
      if @information.update_attributes(params[:information])
        format.html { redirect_to @information, notice: 'Information was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @information.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /information/1
  # DELETE /information/1.json
  def destroy
    @information = Information.find(params[:id])
    @information.destroy

    respond_to do |format|
      format.html { redirect_to information_index_url }
      format.json { head :no_content }
    end
  end
end
