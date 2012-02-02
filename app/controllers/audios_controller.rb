class AudiosController < ApplicationController
  before_filter :handle_unauthorized_request

  def new
    @audio = Audio.new
  end

  def create
    @audio = Audio.find_or_create_by_title(params[:title])
    @audio.add_file(params[:file])

    if @audio.valid?
      redirect_to edit_sidebar_path
    else
      render :new
    end
  end
end
