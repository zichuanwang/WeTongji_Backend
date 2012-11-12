class SchoolNewsController < ApplicationController
  # GET /school_news
  # GET /school_news.json
  def index
    @school_news = SchoolNews.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @school_news }
    end
  end

  # GET /school_news/1
  # GET /school_news/1.json
  def show
    @school_news = SchoolNews.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @school_news }
    end
  end

  # GET /school_news/new
  # GET /school_news/new.json
  def new
    @school_news = SchoolNews.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @school_news }
    end
  end

  # GET /school_news/1/edit
  def edit
    @school_news = SchoolNews.find(params[:id])
  end

  # POST /school_news
  # POST /school_news.json
  def create
    @school_news = SchoolNews.new(params[:school_news])

    respond_to do |format|
      if @school_news.save
        format.html { redirect_to @school_news, notice: 'School news was successfully created.' }
        format.json { render json: @school_news, status: :created, location: @school_news }
      else
        format.html { render action: "new" }
        format.json { render json: @school_news.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /school_news/1
  # PUT /school_news/1.json
  def update
    @school_news = SchoolNews.find(params[:id])

    respond_to do |format|
      if @school_news.update_attributes(params[:school_news])
        format.html { redirect_to @school_news, notice: 'School news was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @school_news.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /school_news/1
  # DELETE /school_news/1.json
  def destroy
    @school_news = SchoolNews.find(params[:id])
    @school_news.destroy

    respond_to do |format|
      format.html { redirect_to school_news_index_url }
      format.json { head :no_content }
    end
  end
end
