class OrganizerRegistersController < ApplicationController
  load_and_authorize_resource
  def index
    @menu = "organizers"
  end

  def show
    @menu = "organizers"
  end

  def new
    render :layout => "out"
  end

  def agreement
    render :layout => "out"
  end

  def form_received
    render :layout => "out"
  end

  def edit
    @menu = "organizers"
  end

  def create
    @menu = "organizers"

    respond_to do |format|
      if @organizer_register.save
        format.html { redirect_to action: "form_received", notice: 'Organizer register was successfully created.' }
      else
        format.html { render action: "new", layout: "out" }
        
      end
    end
  end

  def update
    respond_to do |format|
      if @organizer_register.update_attributes(params[:organizer_register])
        format.html { redirect_to @organizer_register, notice: 'Organizer register was successfully updated.' }
      else
        format.html { render action: "edit" }
      end
    end
  end
end
