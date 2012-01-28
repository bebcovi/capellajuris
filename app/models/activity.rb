class Activity < ActiveRecord::Base
  validates_presence_of :year, :message => "Godina ne smije biti prazna"
end
