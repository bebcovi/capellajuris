# encoding: utf-8
class AudiosController < ApplicationController
  before_filter :handle_unauthorized_request

  def new
    @audio = Audio.new
  end

  def create
    @audio = Audio.create(params[:audio])

    if @audio.valid?
      redirect_to edit_sidebar_path, :notice => "Pjesma je uspješno učitana."
    else
      render :new
    end
  end

  def delete
  end

  def destroy
    @audio = Audio.destroy(params[:id])
    redirect_to :back, :notice => "Audio datoteka je izbrisana."
  end
end
