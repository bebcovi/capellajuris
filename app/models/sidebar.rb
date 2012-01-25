# encoding: utf-8
class Sidebar
  attr_reader :video_title, :video, :audio_title, :audio

  def initialize
    @video_title = "Makedonska humoreska"
    @video = '<iframe width="306" height="180" src="http://www.youtube.com/embed/FAi48kKVTS4?rel=0" frameborder="0" allowfullscreen></iframe>'
    @audio_title = "Makedonsko devojče"
    @audio = ["makedonsko_devojce.mp3", "makedonsko_devojce.ogg"]
  end
end
