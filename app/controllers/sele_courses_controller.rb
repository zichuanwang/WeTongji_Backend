class SeleCoursesController < ApplicationController
  before_filter :authenticate_admin!

  def index
    @menu = 'sele_courses'
    @sele_courses = SeleCourse.order("id desc").page(params[:page])

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @sele_courses }
    end
  end

  def import
    @menu = 'sele_courses'
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
    SeleCourse.import(path).each do |course|
      course.save
    end
    redirect_to sele_courses_path
  end

  def upload
    @menu = 'sele_courses'
  end

  def show
    @sele_course = SeleCourse.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @sele_course }
    end
  end

  # GET /sele_courses/new
  # GET /sele_courses/new.json
  def new
    @sele_course = SeleCourse.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @sele_course }
    end
  end

  # GET /sele_courses/1/edit
  def edit
    @sele_course = SeleCourse.find(params[:id])
  end

  # POST /sele_courses
  # POST /sele_courses.json
  def create
    @sele_course = SeleCourse.new(params[:sele_course])

    respond_to do |format|
      if @sele_course.save
        format.html { redirect_to @sele_course, notice: 'Sele course was successfully created.' }
        format.json { render json: @sele_course, status: :created, location: @sele_course }
      else
        format.html { render action: "new" }
        format.json { render json: @sele_course.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /sele_courses/1
  # PUT /sele_courses/1.json
  def update
    @sele_course = SeleCourse.find(params[:id])

    respond_to do |format|
      if @sele_course.update_attributes(params[:sele_course])
        format.html { redirect_to @sele_course, notice: 'Sele course was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @sele_course.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /sele_courses/1
  # DELETE /sele_courses/1.json
  def destroy
    @sele_course = SeleCourse.find(params[:id])
    @sele_course.destroy

    respond_to do |format|
      format.html { redirect_to sele_courses_url }
      format.json { head :no_content }
    end
  end
end
