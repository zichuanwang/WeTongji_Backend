class SensitivesController < ApplicationController
  # GET /sensitives
  # GET /sensitives.json
  def index
    @sensitives = Sensitive.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @sensitives }
    end
  end

  # GET /sensitives/1
  # GET /sensitives/1.json
  def show
    @sensitive = Sensitive.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @sensitive }
    end
  end

  # GET /sensitives/new
  # GET /sensitives/new.json
  def new
    @sensitive = Sensitive.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @sensitive }
    end
  end

  # GET /sensitives/1/edit
  def edit
    @sensitive = Sensitive.find(params[:id])
  end

  # POST /sensitives
  # POST /sensitives.json
  def create
    @sensitive = Sensitive.new(params[:sensitive])

    respond_to do |format|
      if @sensitive.save
        format.html { redirect_to @sensitive, notice: 'Sensitive was successfully created.' }
        format.json { render json: @sensitive, status: :created, location: @sensitive }
      else
        format.html { render action: "new" }
        format.json { render json: @sensitive.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /sensitives/1
  # PUT /sensitives/1.json
  def update
    @sensitive = Sensitive.find(params[:id])

    respond_to do |format|
      if @sensitive.update_attributes(params[:sensitive])
        format.html { redirect_to @sensitive, notice: 'Sensitive was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @sensitive.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /sensitives/1
  # DELETE /sensitives/1.json
  def destroy
    @sensitive = Sensitive.find(params[:id])
    @sensitive.destroy

    respond_to do |format|
      format.html { redirect_to sensitives_url }
      format.json { head :no_content }
    end
  end
end
