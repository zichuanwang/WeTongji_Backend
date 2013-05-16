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

  def top
    @activity = Activity.find_by_id(params[:id])
    authorize! :top, @activity
    Activity.update_all(:top => false)
    @activity.top = true
    @activity.save
    redirect_to :action => "index"
  end

  def create
    @activity.admin = current_admin
    @activity.check
    set_time
    if @activity.save
      redirect_to :action => "index", notice: 'Activity was successfully created.'
    else
      render action: "new" 
    end
  end

  def update
    set_time
    if @activity.update_attributes(params[:activity])
      @activity.check
      @activity.save
      redirect_to @activity, notice: 'Activity was successfully updated.'
    else
      render action: "edit"
    end
  end

  def destroy
    @activity.delete
    redirect_to activities_url
  end

  private

  def set_time
    @activity.begin = Time.parse("#{params[:date][:day]} #{params[:date][:begin_time]}:00")
    @activity.end = Time.parse("#{params[:date][:day]} #{params[:date][:end_time]}:00")
  end
end
