class ActivitiesController < ApplicationController
  load_and_authorize_resource

  def index
    @activities = @activities.order("id desc").page(params[:page])
  end

  def show
  end

  def new
  end

  def edit
  end

  def approve
    @activity = Activity.find_by_id(params[:id])
    authorize! :approve, @activity
    @activity.visiable = true
    @activity.is_pending = false
    @activity.pending_reason = ""
    @activity.save
    redirect_to :action => "index"
  end

  def create
    @activity.admin = current_admin
    @activity.check
    respond_to do |format|
      if @activity.save
        format.html { redirect_to :action => "index", notice: 'Activity was successfully created.' }
      else
        format.html { render action: "new" }
      end
    end
  end

  def update
    respond_to do |format|
      if @activity.update_attributes(params[:activity])
        @activity.check
        @activity.save
        format.html { redirect_to @activity, notice: 'Activity was successfully updated.' }
      else
        format.html { render action: "edit" }
      end
    end
  end

  def destroy
    @activity.delete

    respond_to do |format|
      format.html { redirect_to activities_url }
      format.json { head :no_content }
    end
  end
end
