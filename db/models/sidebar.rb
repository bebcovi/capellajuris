class Sidebar < ActiveRecord::Base
  validate :audio_existence

  def audio_existence
    if not Dir['public/audio/*'].include? "public/audio/#{audio}.mp3"
      errors.add(:audio, "Audio snimka s tim imenom ne postoji.")
    end
  end

  before_save :set_equal_dimensions

  def set_equal_dimensions
    self.video.
      sub!(/height=('|")\d+('|")/, "height=\"176\"").
      sub!(/width=('|")\d+('|")/, "width=\"300\"") if video.present?
  end
end
