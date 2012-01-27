class VideosController < ApplicationController
  def index
    @videos = Video.all
  end

  def new
    @video = Video.new
  end

  def create
    Video.create(params[:video])
    redirect_to :action => :index
  end

  def destroy
    Video.destroy(params[:id])
    redirect_to :action => :index
  end
end
