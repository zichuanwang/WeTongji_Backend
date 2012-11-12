class AroundsController < ApplicationController
  # GET /arounds
  # GET /arounds.json
  def index
    @arounds = Around.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @arounds }
    end
  end

  # GET /arounds/1
  # GET /arounds/1.json
  def show
    @around = Around.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @around }
    end
  end

  # GET /arounds/new
  # GET /arounds/new.json
  def new
    @around = Around.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @around }
    end
  end

  # GET /arounds/1/edit
  def edit
    @around = Around.find(params[:id])
  end

  # POST /arounds
  # POST /arounds.json
  def create
    @around = Around.new(params[:around])

    respond_to do |format|
      if @around.save
        format.html { redirect_to @around, notice: 'Around was successfully created.' }
        format.json { render json: @around, status: :created, location: @around }
      else
        format.html { render action: "new" }
        format.json { render json: @around.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /arounds/1
  # PUT /arounds/1.json
  def update
    @around = Around.find(params[:id])

    respond_to do |format|
      if @around.update_attributes(params[:around])
        format.html { redirect_to @around, notice: 'Around was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @around.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /arounds/1
  # DELETE /arounds/1.json
  def destroy
    @around = Around.find(params[:id])
    @around.destroy

    respond_to do |format|
      format.html { redirect_to arounds_url }
      format.json { head :no_content }
    end
  end
end
