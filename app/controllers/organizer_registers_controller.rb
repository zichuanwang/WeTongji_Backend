class OrganizerRegistersController < ApplicationController
  before_filter :authenticate_admin!, :except => [:new, :agreement, :form_received]
  load_and_authorize_resource
  def index
    @menu = "organizers"
    @organizer_registers = OrganizerRegister.accessible_by(current_ability).order('id desc').page(params[:page])
  end

  def show
    @menu = "organizers"
    @organizer_register = OrganizerRegister.find(params[:id])
  end

  def new
    render :layout => "out"
    @organizer_register = OrganizerRegister.new
  end

  def agreement
    render :layout => "out"
  end

  def form_received
    render :layout => "out"
  end

  def edit
    @menu = "organizers"
    @organizer_register = OrganizerRegister.find(params[:id])
  end

  def create
    @menu = "organizers"
    @organizer_register = OrganizerRegister.new(params[:organizer_register])

    respond_to do |format|
      if @organizer_register.save
        format.html { redirect_to action: "form_received", notice: 'Organizer register was successfully created.' }
      else
        format.html { render action: "new", layout: "out" }
        
      end
    end
  end

  def update
    @organizer_register = OrganizerRegister.find(params[:id])
    respond_to do |format|
      if @organizer_register.update_attributes(params[:organizer_register])
        format.html { redirect_to @organizer_register, notice: 'Organizer register was successfully updated.' }
      else
        format.html { render action: "edit" }
      end
    end
  end
end
