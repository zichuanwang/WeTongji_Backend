class InformationController < ApplicationController
  load_and_authorize_resource
  def index
    @information = @information.order("id desc").page(params[:page])
  end

  def show
  end

  def new
  end

  def edit
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
    @information.admin = current_admin
    @information.check

    respond_to do |format|
      if @information.save
        format.html { redirect_to @information, notice: 'Information was successfully created.' }
      else
        format.html { render action: "new" }
      end
    end
  end


  def update

    respond_to do |format|
      if @information.update_attributes(params[:information])
        @information.check
        @information.save
        format.html { redirect_to @information, notice: 'Information was successfully updated.' }
      else
        format.html { render action: "edit" }
      end
    end
  end

  def destroy
    @information.destroy

    respond_to do |format|
      format.html { redirect_to information_index_url }
    end
  end
end
