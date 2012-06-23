class ChannelsController < ApplicationController
  load_and_authorize_resource
  def index
    @menu = 'channels'
  end

  def show
    @menu = 'channels'
  end

  def new
    @menu = 'channels'
  end

  def edit
    @menu = 'channels'
  end

  def create
    @menu = 'channels'
    @channel = Channel.new(params[:channel])

    respond_to do |format|
      if @channel.save
        format.html { redirect_to :action => "index", notice: 'Channel was successfully created.' }
      else
        format.html { render action: "new" }
      end
    end
  end

  def update
    @channel = Channel.find(params[:id])

    respond_to do |format|
      if @channel.update_attributes(params[:channel])
        format.html { redirect_to :action => "index", notice: 'Channel was successfully updated.' }
      else
        format.html { render action: "edit" }
      end
    end
  end

end
