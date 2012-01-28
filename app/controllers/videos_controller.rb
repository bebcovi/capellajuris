class VideosController < ApplicationController
  def index
    @videos = Video.all
  end

  def new
    @video = Video.new
  end

  def create
    @video = Video.create(params[:video])

    if @video.valid?
      redirect_to videos_path
    else
      render :new
    end
  end

  def destroy
    Video.destroy(params[:id])
    redirect_to :action => :index
  end
end
