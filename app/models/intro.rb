class Intro
  attr_reader :title, :photo, :text

  def initialize
    @title = "Capella Juris"
    @photo = '<img src="/images/capella_juris.jpg" alt="Capella juris" />'
    @text = File.read("app/models/content/intro.md")
  end
end
