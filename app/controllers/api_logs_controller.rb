class ApiLogsController < ApplicationController
  # GET /api_logs
  # GET /api_logs.json
  def index
    @api_logs = ApiLog.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @api_logs }
    end
  end

  # GET /api_logs/1
  # GET /api_logs/1.json
  def show
    @api_log = ApiLog.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @api_log }
    end
  end

  # GET /api_logs/new
  # GET /api_logs/new.json
  def new
    @api_log = ApiLog.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @api_log }
    end
  end

  # GET /api_logs/1/edit
  def edit
    @api_log = ApiLog.find(params[:id])
  end

  # POST /api_logs
  # POST /api_logs.json
  def create
    @api_log = ApiLog.new(params[:api_log])

    respond_to do |format|
      if @api_log.save
        format.html { redirect_to @api_log, notice: 'Api log was successfully created.' }
        format.json { render json: @api_log, status: :created, location: @api_log }
      else
        format.html { render action: "new" }
        format.json { render json: @api_log.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /api_logs/1
  # PUT /api_logs/1.json
  def update
    @api_log = ApiLog.find(params[:id])

    respond_to do |format|
      if @api_log.update_attributes(params[:api_log])
        format.html { redirect_to @api_log, notice: 'Api log was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @api_log.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /api_logs/1
  # DELETE /api_logs/1.json
  def destroy
    @api_log = ApiLog.find(params[:id])
    @api_log.destroy

    respond_to do |format|
      format.html { redirect_to api_logs_url }
      format.json { head :no_content }
    end
  end
end
