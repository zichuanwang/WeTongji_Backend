class StoriesController < ApplicationController
  load_and_authorize_resource
  def index
    @stories = @stories.order("id desc").where("for_admin = 1").page(params[:page])
  end

  def show
  end
end
