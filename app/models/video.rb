class Video < ActiveRecord::Base
  validates_presence_of :link, :message => "YouTube video ne smije biti prazan."

  before_create do
    if link =~ /"/
      self.link = link.gsub(%["], %['])
    elsif link =~ /'/
      self.link = link.gsub(%['], %["])
    else
      true
    end
  end

  def page
    Video.all.each_with_index do |video, index|
      return ((index + 1)/3.0).ceil if self == video
    end
  end
end
