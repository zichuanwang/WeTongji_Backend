class NewsController < ApplicationController
  load_and_authorize_resource
  def index
    @menu = 'news'
    @news = @news.order("id desc").page(params[:page])
  end

  def show
    @menu = 'news'
  end

  def new
    @menu = 'news'
  end

  def edit
    @menu = 'news'
  end

  def create
    @menu = 'news'
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
