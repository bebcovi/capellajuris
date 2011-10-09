class Sidebar < ActiveRecord::Base
  validate :audio_existence

  def audio_existence
    if not Dir['public/audio/*'].include? "public/audio/#{audio}.mp3"
      errors.add(:audio, "Audio snimka s tim imenom ne postoji.")
    end
  end

  def video
    video = Hpricot(read_attribute(:video)).at(:iframe)
    video[:height], video[:width] = '180', '306'
    return video.to_html
  end
end
