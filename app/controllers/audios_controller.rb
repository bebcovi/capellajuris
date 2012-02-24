# encoding: utf-8
class AudiosController < ApplicationController
  before_filter :authorize

  def manage
    @audio = Audio.new
  end

  def create
    @audio = Audio.new(params[:audio])

    if @audio.save
      redirect_to manage_audios_path, :notice => "Pjesma \"#{@audio.title}\" je uspješno spremljena."
    else
      render :manage
    end
  end

  def delete
  end

  def destroy
    @audio = Audio.destroy(params[:id])
    redirect_to :back, :notice => "Pjesma je uspješno izbrisana."
  end
end
