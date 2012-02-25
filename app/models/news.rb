# encoding: utf-8
class News < ActiveRecord::Base
  validates_presence_of :title, :message => "Naslov ne smije biti prazan."
  validates_presence_of :text, :message => "Sadržaj ne smije biti prazan."

  after_create do
    self.class.order(:created_at).first.destroy if self.class.count > 100
  end
end
