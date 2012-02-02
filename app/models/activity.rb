class Activity < ActiveRecord::Base
  validates_presence_of :year, :message => "Godina ne smije biti prazna"
  validates_presence_of :bullets, :message => "Sadržaj ne smije biti prazan"
end
