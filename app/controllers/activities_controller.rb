class ActivitiesController < ApplicationController
  authorize_resource

  def index
    @menu = 'activities'
    @activities = Activity.order("id desc")

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @activities }
    end
  end

  def show
    @menu = 'activities'
    @activity = Activity.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @activity }
    end
  end

  def new
    @menu = 'activities'
    @activity = Activity.new
    
    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @activity }
    end
  end

  def edit
    @menu = 'activities'
    @activity = Activity.find(params[:id])
  end

  def create
    @menu = 'activities'
    @activity = Activity.new(params[:activity])
    #channel = Channel.find(params[:channel_id])

    #@activity.channel = channel

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

  # PUT /activities/1
  # PUT /activities/1.json
  def update
    @menu = 'activities'
    @activity = Activity.find(params[:id])

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

  # DELETE /activities/1
  # DELETE /activities/1.json
  def destroy
    @activity = Activity.find(params[:id])
    @activity.destroy

    respond_to do |format|
      format.html { redirect_to activities_url }
      format.json { head :no_content }
    end
  end
end
