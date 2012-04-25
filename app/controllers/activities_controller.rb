class ActivitiesController < ApplicationController
  before_filter :authenticate_admin!

  def index
    @activities = nil
    if params[:channel_id]
      @activities = Activity.where("channel_id = :channel_id", :channel_id => params[:channel_id]).order("id desc")
    else
      @activities = Activity.order("id desc")
    end

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @activities }
    end
  end

  def show
    @activity = Activity.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @activity }
    end
  end

  def new
    @activity = Activity.new
    if params[:channel_id]
      channel = Channel.find(params[:channel_id])
      @activity.channel = channel
    end
    
    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @activity }
    end
  end

  def edit
    @activity = Activity.find(params[:id])
  end

  def create
    @activity = Activity.new(params[:activity])
    #channel = Channel.find(params[:channel_id])

    #@activity.channel = channel

    respond_to do |format|
      if @activity.save
        format.html { redirect_to :action => "index", :channel_id => @activity.channel.id, notice: 'Activity was successfully created.' }
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
