class VideosController < ApplicationController
  def index
    @videos = Video.order(:id)
  end

  def new
    @video = Video.new
  end

  def create
    @video = Video.create(params[:video])

    if @video.valid?
      redirect_to "#{videos_path}#last"
    else
      render :new
    end
  end

  def destroy
    Video.destroy(params[:id])
    redirect_to videos_path
  end
end
