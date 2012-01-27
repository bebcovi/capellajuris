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
               :photo => '<a href="http://www.flickr.com/photos/67131352@N04/6109212283/" title="povijest_zbora by Janko Marohnić, on Flickr"><img src="http://farm7.staticflickr.com/6076/6109212283_41d11b788a_m.jpg" width="240" height="162" alt="povijest_zbora"></a>',
               :text => File.read("app/models/content/povijest_zbora.md")),
      self.new(:title => "Biografija dirigenta",
               :photo => '<a href="http://www.flickr.com/photos/67131352@N04/6109212199/" title="biografija_dirigenta by Janko Marohnić, on Flickr"><img src="http://farm7.staticflickr.com/6090/6109212199_3a843ae74c_m.jpg" width="158" height="108" alt="biografija_dirigenta"></a>',
               :text => File.read("app/models/content/biografija_dirigenta.md"))
    ]
  end
end
