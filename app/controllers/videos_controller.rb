class VideosController < ApplicationController
  before_filter :handle_unauthorized_request

  def new
    @video = Video.new
  end

  def create
    @video = Video.create(params[:video])

    if @video.valid?
      redirect_to last_video_page
    else
      render :new
    end
  end

  def destroy
    Video.destroy(params[:id])
    redirect_to videos_path
  end

private

  def last_video_page
    (Video.count / 3).ceil
  end
end
