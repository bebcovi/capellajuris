class AudioUploader < CarrierWave::Uploader::Base
  storage :fog

  def store_dir
    nil
  end
end
