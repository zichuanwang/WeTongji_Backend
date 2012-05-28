class ExamsController < ApplicationController
  authorize_resource

  def upload
    @menu = 'exams'
  end

  def import
    @menu = 'exams'
    name =  params['file'].original_filename
    directory = "public/imports"
    if !File.exist?(directory)
      Dir.mkdir(directory)
    end
    # create the file path
    path = File.join(directory, name)
    # write the file
    File.open(path, "wb") { |f| f.write(params['file'].read) }
    p path
    Exam.import(path).each do |exam|
      exam.save
    end
    redirect_to exams_path
  end

  def index
    @menu = 'exams'
    @exams = Exam.order("id desc").page(params[:page])

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @exams }
    end
  end

  # GET /exams/1
  # GET /exams/1.json
  def show
    @exam = Exam.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @exam }
    end
  end

  # GET /exams/new
  # GET /exams/new.json
  def new
    @exam = Exam.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @exam }
    end
  end

  # GET /exams/1/edit
  def edit
    @exam = Exam.find(params[:id])
  end

  # POST /exams
  # POST /exams.json
  def create
    @exam = Exam.new(params[:exam])

    respond_to do |format|
      if @exam.save
        format.html { redirect_to @exam, notice: 'Exam was successfully created.' }
        format.json { render json: @exam, status: :created, location: @exam }
      else
        format.html { render action: "new" }
        format.json { render json: @exam.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /exams/1
  # PUT /exams/1.json
  def update
    @exam = Exam.find(params[:id])

    respond_to do |format|
      if @exam.update_attributes(params[:exam])
        format.html { redirect_to @exam, notice: 'Exam was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @exam.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /exams/1
  # DELETE /exams/1.json
  def destroy
    @exam = Exam.find(params[:id])
    @exam.destroy

    respond_to do |format|
      format.html { redirect_to exams_url }
      format.json { head :no_content }
    end
  end
end
