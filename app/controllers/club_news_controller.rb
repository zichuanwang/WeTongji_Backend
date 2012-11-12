class ClubNewsController < ApplicationController
  # GET /club_news
  # GET /club_news.json
  def index
    @club_news = ClubNews.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @club_news }
    end
  end

  # GET /club_news/1
  # GET /club_news/1.json
  def show
    @club_news = ClubNews.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @club_news }
    end
  end

  # GET /club_news/new
  # GET /club_news/new.json
  def new
    @club_news = ClubNews.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @club_news }
    end
  end

  # GET /club_news/1/edit
  def edit
    @club_news = ClubNews.find(params[:id])
  end

  # POST /club_news
  # POST /club_news.json
  def create
    @club_news = ClubNews.new(params[:club_news])

    respond_to do |format|
      if @club_news.save
        format.html { redirect_to @club_news, notice: 'Club news was successfully created.' }
        format.json { render json: @club_news, status: :created, location: @club_news }
      else
        format.html { render action: "new" }
        format.json { render json: @club_news.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /club_news/1
  # PUT /club_news/1.json
  def update
    @club_news = ClubNews.find(params[:id])

    respond_to do |format|
      if @club_news.update_attributes(params[:club_news])
        format.html { redirect_to @club_news, notice: 'Club news was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @club_news.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /club_news/1
  # DELETE /club_news/1.json
  def destroy
    @club_news = ClubNews.find(params[:id])
    @club_news.destroy

    respond_to do |format|
      format.html { redirect_to club_news_index_url }
      format.json { head :no_content }
    end
  end
end
