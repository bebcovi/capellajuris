# encoding: utf-8
class VideosController < ApplicationController
  before_filter :authorize

  def new
    @video = Video.new
  end

  def create
    @video = Video.create(params[:video])

    if @video.valid?
      redirect_to videos_path(:page => @video.page), :notice => "Video je uspješno dodan."
    else
      render :new
    end
  end

  def destroy
    Video.destroy(params[:id])
    redirect_to videos_path, :notice => "Video je uspješno izbrisan."
  end
end
