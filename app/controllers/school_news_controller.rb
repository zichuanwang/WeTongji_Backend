class SchoolNewsController < ApplicationController
  load_and_authorize_resource
  def index
    @school_news = @school_news.order("id desc").page(params[:page])
  end

  def show
  end

  def new
  end

  def edit
  end

  def approve
    @school_news = SchoolNews.find_by_id(params[:id])
    authorize! :approve, @school_news
    @school_news.visiable = true
    @school_news.is_pending = false
    @school_news.pending_reason = ""
    @school_news.save
    redirect_to :action => "index"
  end

  def create
    @school_news.admin = current_admin
    @school_news.check

    if params[:images]
      params[:images].each do |image|
        img = SchoolNewsImage.new
        img.file = image
        @school_news.school_news_images << img
      end
    end

    respond_to do |format|
      if @school_news.save
        format.html { redirect_to @school_news, notice: 'School News was successfully created.' }
      else
        format.html { render action: "new" }
      end
    end
  end

  def update
    if params[:images]
      params[:images].each do |image|
        img = SchoolNewsImage.new
        img.file = image
        @school_news.school_news_images << img
      end
    end

    if params[:delete_images]
      params[:delete_images].each do |image|
        img = SchoolNewsImage.find(image)
        @school_news.school_news_images.delete(img)
      end
    end
    
    respond_to do |format|
      if @school_news.update_attributes(params[:school_news])
        @school_news.check
        @school_news.save
        format.html { redirect_to @school_news, notice: 'School News was successfully updated.' }
      else
        format.html { render action: "edit" }
      end
    end
  end

  def destroy
    @school_news.destroy

    respond_to do |format|
      format.html { redirect_to school_news_index_url }
    end
  end
end
