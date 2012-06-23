class OrganizersController < ApplicationController
  load_and_authorize_resource
  def index
    @organizers = @organizers.order("id desc")
    @menu = "organizers"
  end

  def show
    @menu = "organizers"
  end

  def new
    @menu = "organizers"
  end

  def edit
    @menu = "organizers"
  end

  def create
    @menu = "organizers"
    respond_to do |format|
      if @organizer.save
        format.html { redirect_to :action => "index", notice: 'Organizer was successfully created.' }
      else
        format.html { render action: "new" }
      end
    end
  end

  def update
    respond_to do |format|
      if @organizer.update_attributes(params[:organizer])
        format.html { redirect_to  :action => "index", notice: 'Organizer was successfully updated.' }
      else
        format.html { render action: "edit" }
      end
    end
  end

  def destroy
    @organizer = Organizer.find(params[:id])
    @organizer.destroy

    respond_to do |format|
      format.html { redirect_to organizers_url }
    end
  end

end
