class Sidebar < ActiveRecord::Base
  serialize :audio
  attr_accessor :audio_aac, :audio_ogg

  after_find do
    if audio.is_a?(Array)
      self.audio_aac, self.audio_ogg = audio
    else
      if audio[/\.\w+$/] == ".aac"
        self.audio_aac = audio
      elsif audio[/\.\w+$/] == ".ogg"
        self.audio_ogg = audio
      end
    end
  end

  before_validation do
    if audio_aac.present? and audio_ogg.present?
      self.audio = [audio_aac, audio_ogg]
    else
      self.audio = audio_aac || audio_ogg
    end
  end

  validates_presence_of :video_title, :message => "Naslov videa ne smije biti prazan"
  validates_presence_of :video, :message => "Video ne smije biti prazan"
  validates_presence_of :audio_title, :message => "Naslov pjesme ne smije biti prazan"
  validates_presence_of :audio, :message => "Pjesma mora biti prisutna (barem u jednom formatu)"

  before_save do
    if video =~ /"/
      self.video = video.gsub(%["], %['])
    elsif video =~ /'/
      self.video = video.gsub(%['], %["])
    end
  end

  def self.the_only
    self.first
  end
end
