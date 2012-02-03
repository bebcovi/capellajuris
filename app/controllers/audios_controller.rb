# encoding: utf-8
class AudiosController < ApplicationController
  before_filter :handle_unauthorized_request

  def new
  end

  def create
    if validations_pass?
      file = Audio.upload(params[:file])
      Audio.find_or_create_by_title(params[:title]).add_file!(file)
      redirect_to edit_sidebar_path
    else
      @errors = validation_errors
      render :new
    end
  end

  def autocomplete
    @audios = Audio.order(:title).where("title ILIKE ?", "%#{params[:term]}%")
    render :json => @audios.collect(&:title)
  end

private

  def validations_pass?
    [params[:title], params[:file]].none? { |user_input| user_input.blank? }
  end

  def validation_errors
    [].tap do |errors|
      errors << "Naslov pjesme ne smije biti prazan." if params[:title].blank?
      errors << "Audio datoteka nije učitana." if params[:file].blank?
      if params[:file].present? and AmazonAudio.exists?(params[:file])
        errors << "Audio snimka s tim imenom datoteke već postoji (#{params[:file].original_filename})."
      end
    end
  end
end
