class NewsController < ApplicationController
  load_and_authorize_resource
  def index
    @news = @news.order("id desc").page(params[:page])
  end

  def show
  end

  def new
  end

  def edit
  end

  def approve
    @news = News.find_by_id(params[:id])
    authorize! :approve, @news
    @news.visiable = true
    @news.is_pending = false
    @news.pending_reason = ""
    @news.save
    redirect_to :action => "index"
  end

  def create
    @news.admin = current_admin
    @news.check
    respond_to do |format|
      if @news.save
        format.html { redirect_to :action => "index", notice: 'News was successfully created.' }
      else
        format.html { render action: "new" }
      end
    end
  end

  def update
    @menu = 'news'
    respond_to do |format|
      if @news.update_attributes(params[:news])
        @news.check
        @news.save
        format.html { redirect_to :action => "index", notice: 'News was successfully updated.' }
      else
        format.html { render action: "edit" }
      end
    end
  end

  def destroy
    @news.destroy

    respond_to do |format|
      format.html { redirect_to :action => "index" }
    end
  end
end
