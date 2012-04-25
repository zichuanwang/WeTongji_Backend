class OrganizersController < ApplicationController
  # GET /organizers
  # GET /organizers.json
  def index
    @organizers = Organizer.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @organizers }
    end
  end

  # GET /organizers/1
  # GET /organizers/1.json
  def show
    @organizer = Organizer.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @organizer }
    end
  end

  # GET /organizers/new
  # GET /organizers/new.json
  def new
    @organizer = Organizer.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @organizer }
    end
  end

  # GET /organizers/1/edit
  def edit
    @organizer = Organizer.find(params[:id])
  end

  # POST /organizers
  # POST /organizers.json
  def create
    @organizer = Organizer.new(params[:organizer])

    respond_to do |format|
      if @organizer.save
        format.html { redirect_to @organizer, notice: 'Organizer was successfully created.' }
        format.json { render json: @organizer, status: :created, location: @organizer }
      else
        format.html { render action: "new" }
        format.json { render json: @organizer.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /organizers/1
  # PUT /organizers/1.json
  def update
    @organizer = Organizer.find(params[:id])

    respond_to do |format|
      if @organizer.update_attributes(params[:organizer])
        format.html { redirect_to @organizer, notice: 'Organizer was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @organizer.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /organizers/1
  # DELETE /organizers/1.json
  def destroy
    @organizer = Organizer.find(params[:id])
    @organizer.destroy

    respond_to do |format|
      format.html { redirect_to organizers_url }
      format.json { head :no_content }
    end
  end
end
