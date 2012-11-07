class PeopleController < ApplicationController
  load_and_authorize_resource
  def index
    @people = @people.order("id desc").page(params[:page])
  end

  def show
  end

  def new
  end

  def edit
    @person = Person.find(params[:id])
  end

  def create
    if params[:images]
      params[:images].each do |image|
        unless image['title'].blank? || image['file'].nil?
          img = PersonImage.new
          img.file = image['file']
          img.title = image['title']
          @person.person_images << img
        end
      end
    end

    respond_to do |format|
      if @person.save
        format.html { redirect_to @person, notice: 'Person was successfully created.' }
      else
        format.html { render action: "new" }
      end
    end
  end

  def update
    @person = Person.find(params[:id])

    respond_to do |format|
      if @person.update_attributes(params[:person])
        format.html { redirect_to @person, notice: 'Person was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @person.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /people/1
  # DELETE /people/1.json
  def destroy
    @person = Person.find(params[:id])
    @person.destroy

    respond_to do |format|
      format.html { redirect_to people_url }
      format.json { head :no_content }
    end
  end
end
