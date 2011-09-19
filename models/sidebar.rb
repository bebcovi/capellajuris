# encoding:utf-8
class Sidebar < Sequel::Model
  set_schema do
    primary_key :id
    column :video_title, 'varchar(50)'
    column :video, 'varchar(255)'
    column :audio_title, 'varchar(50)'
    column :audio, 'varchar(255)'
  end

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
