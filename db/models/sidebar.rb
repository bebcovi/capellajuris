# encoding:utf-8
class Sidebar < Sequel::Model
  def validates_audio_existence(column)
    if not Dir['public/audio/*'].include? "public/audio/#{audio}.mp3"
      errors.add(columns, "Audio snimka s tim imenom ne postoji.")
    end
  end

  def validate
    super
    validates_audio_existence :audio
  end

  def before_update
    self.video.sub!(/height\="\d+"/, 'height="176"').sub!(/width\="\d+"/, 'width="300"')
  end
end
