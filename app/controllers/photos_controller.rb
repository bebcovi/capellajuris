class PhotosController < ApplicationController
  def index
    @photos = (1..19).collect { |number| "/images/gallery/#{number}.jpg" }
  end
end
