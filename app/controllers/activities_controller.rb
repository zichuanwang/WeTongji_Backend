class ActivitiesController < ApplicationController
  load_and_authorize_resource

  def index
    @menu = 'activities'
    @activities = @activities.order("id desc").page(params[:page])
  end

  def show
    @menu = 'activities'
  end

  def new
    @menu = 'activities'
  end

  def edit
    @menu = 'activities'
  end

  def create
    @menu = 'activities'
    #channel = Channel.find(params[:channel_id])

    #@activity.channel = channel
    @activity.check
    respond_to do |format|
      if @activity.save
        format.html { redirect_to :action => "index", notice: 'Activity was successfully created.' }
        format.json { render json: @activity, status: :created, location: @activity }
      else
        format.html { render action: "new" }
        format.json { render json: @activity.errors, status: :unprocessable_entity }
      end
    end
  end

  def update
    @menu = 'activities'
    @activity.check
    respond_to do |format|
      if @activity.update_attributes(params[:activity])
        format.html { redirect_to @activity, notice: 'Activity was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @activity.errors, status: :unprocessable_entity }
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
