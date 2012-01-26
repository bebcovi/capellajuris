# encoding: utf-8
class Home
  def self.get_intro
    {
      :title => "Capella Juris",
      :photo => '<img src="/images/capella_juris.jpg" alt="Capella juris" />',
      :text => File.read("app/models/content/intro.md")
    }
  end

  def self.get_sidebar
    {
      :video_title => "Makedonska humoreska",
      :video => '<iframe width="306" height="180" src="http://www.youtube.com/embed/FAi48kKVTS4?rel=0" frameborder="0" allowfullscreen></iframe>',
      :audio_title => "Makedonsko devojče",
      :audio => ["makedonsko_devojce.mp3", "makedonsko_devojce.ogg"]
    }
  end
end
