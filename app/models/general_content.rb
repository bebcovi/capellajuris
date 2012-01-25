# encoding: utf-8
class GeneralContent
  attr_reader :title, :photo, :text

  def initialize(options = {})
    @title = options[:title]
    @photo = options[:photo]
    @text = options[:text]
  end

  def self.all
    [
      self.new(:title => "Povijest zbora",
               :photo => '<img src="/images/povijest_zbora.jpg" alt="Povijest zbora" />',
               :text => File.read("app/models/content/povijest_zbora.md")),
      self.new(:title => "Biografija dirigenta",
               :photo => '<img src="/images/biografija_dirigenta.jpg" alt="Jurica Petar Petrač" />',
               :text => File.read("app/models/content/biografija_dirigenta.md"))
    ]
  end
end
