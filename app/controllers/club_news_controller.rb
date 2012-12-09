class ClubNewsController < ApplicationController
  load_and_authorize_resource
  def index
    @club_news = @club_news.order("id desc").page(params[:page])
  end

  def show
  end

  def new
  end

  def edit
  end

  def approve
    @club_news = ClubNews.find_by_id(params[:id])
    authorize! :approve, @club_news
    @club_news.visiable = true
    @club_news.is_pending = false
    @club_news.pending_reason = ""
    @club_news.save
    redirect_to :action => "index"
  end

  def create
    @club_news.admin = current_admin
    @club_news.check

    if params[:images]
      params[:images].each do |image|
        img = ClubNewsImage.new
        img.file = image
        @club_news.club_news_images << img
      end
    end

    respond_to do |format|
      if @club_news.save
        format.html { redirect_to @club_news, notice: 'Club News was successfully created.' }
      else
        format.html { render action: "new" }
      end
    end
  end

  def update
    if params[:images]
      params[:images].each do |image|
        img = ClubNewsImage.new
        img.file = image
        @club_news.club_news_images << img
      end
    end

    if params[:delete_images]
      params[:delete_images].each do |image|
        img = ClubNewsImage.find(image)
        @club_news.club_news_images.delete(img)
      end
    end
    
    respond_to do |format|
      if @club_news.update_attributes(params[:club_news])
        @club_news.check
        @club_news.save
        format.html { redirect_to @club_news, notice: 'club News was successfully updated.' }
      else
        format.html { render action: "edit" }
      end
    end
  end

  def destroy
    @club_news.destroy

    respond_to do |format|
      format.html { redirect_to club_news_index_url }
    end
  end
end
