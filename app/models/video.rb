class Video < ActiveRecord::Base
  validates_presence_of :link, :message => "YouTube video ne smije biti prazan"

  before_create do
    if link =~ /"/
      self.link = link.gsub(%["], %['])
    elsif link =~ /'/
      self.link = link.gsub(%['], %["])
    end
  end
end
