class Sidebar < ActiveRecord::Base
  belongs_to :audio

  validates_presence_of :video_title, :message => "Naslov videa ne smije biti prazan."
  validates_presence_of :video, :message => "Video ne smije biti prazan."

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
