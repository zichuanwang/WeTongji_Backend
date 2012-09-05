class OrganizerRegistersController < ApplicationController
  before_filter :authenticate_admin!, :except => [:new, :form_received, :create]
  def index
    @menu = "organizers"
    @organizer_registers = OrganizerRegister.accessible_by(current_ability).order('id desc').page(params[:page])
  end

  def show
    @menu = "organizers"
    @organizer_register = OrganizerRegister.find(params[:id])
  end

  def new
    @organizer_register = OrganizerRegister.new
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
        @organizer_register.approved_at = Time.now
        @organizer_register.save
        admin = Admin.find_by_email(@organizer_register.account)
        if admin.nil?
          admin = Admin.create(:email => @organizer_register.account, :password => @organizer_register.password, :role => "OrganizerAdmin", :password_confirmation => @organizer_register.password)
        end
        @organizer = Organizer.find_by_name(@organizer_register.name)
        if @organizer.nil?
          @organizer = Organizer.new
          @organizer.name = @organizer_register.name
          @organizer.description = @organizer_register.description
          @organizer.icon = @organizer_register.icon
          @organizer.admin = admin
          @organizer.save
        end
        OrganizerRegisterMailer.welcome(admin).deliver
        format.html { redirect_to @organizer_register, notice: 'Organizer register was successfully updated.' }
      else
        format.html { render action: "edit" }
      end
    end
  end
end
