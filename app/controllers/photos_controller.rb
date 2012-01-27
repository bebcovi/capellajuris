class PhotosController < ApplicationController
  def index
    @photos = Flickr.photos_from_set(admin[:flickr_set]).collect(&:largest)
  end
end
