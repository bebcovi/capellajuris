# encoding: utf-8
class Home
  def self.get_intro
    {
      :title => "Capella Juris",
      :photo => '<a href="http://www.flickr.com/photos/67131352@N04/6109212127/"><img src="http://farm7.staticflickr.com/6077/6109212127_ebdf4f9f49_m.jpg" width="240" height="161" alt="Capella juris"></a>',
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
