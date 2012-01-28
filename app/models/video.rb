class Video < ActiveRecord::Base
  validates_presence_of :link, :message => "YouTube video ne smije biti prazan"

end
