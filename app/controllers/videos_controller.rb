# encoding: utf-8
class VideosController < ApplicationController
  before_filter :handle_unauthorized_request

  def new
    @video = Video.new
  end

  def create
    @video = Video.create(params[:video])

    if @video.valid?
      redirect_to videos_path(:page => @video.page), :success => "Video je uspješno dodan."
    else
      render :new
    end
  end

  def destroy
    video = Video.destroy(params[:id])
    redirect_to videos_path, :success => "Video je uspješno izbrisan."
  end

private
end
