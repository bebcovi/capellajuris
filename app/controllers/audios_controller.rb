class AudiosController < ApplicationController
  before_filter :handle_unauthorized_request

  def new
    @audio = Audio.new
  end

  def create
    @audio = Audio.new(params[:audio])

    if @audio.valid?
      Audio.find_or_create_by_title(params[:audio][:title]).add_file(params[:audio][:file])
      redirect_to edit_sidebar_path
    else
      render :new
    end
  end
end
