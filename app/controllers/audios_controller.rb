# encoding: utf-8
class AudiosController < ApplicationController
  before_filter :handle_unauthorized_request

  def new
    @audio = Audio.new
  end

  def create
    @audio = Audio.create(params[:audio])

    if @audio.valid?
      flash[:success] = "Pjesma je uspješno učitana."
      redirect_to edit_sidebar_path
    else
      render :new
    end
  end
end
