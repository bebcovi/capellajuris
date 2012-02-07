# encoding: utf-8
class AudiosController < ApplicationController
  before_filter :handle_unauthorized_request

  def manage
    @audio = Audio.new
    render :new
  end

  def create
    @audio = Audio.new(params[:audio])

    if @audio.save
      redirect_to manage_audios_path, :notice => "Pjesma je \"#{@audio.title}\" uspješno spremljena."
    else
      render :new
    end
  end

  def delete
  end

  def destroy
    @audio = Audio.destroy(params[:id])
    redirect_to :back, :notice => "Pjesma je uspješno izbrisana."
  end
end
