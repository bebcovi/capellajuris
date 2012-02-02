# encoding: utf-8
require 'amazon_audio'
class Audio < ActiveRecord::Base
  serialize :files, Array

  def add_file(file)
    if AmazonAudio.exists?(file)
      errors[:base] << "Audio snimka s tim imenom datoteke već postoji"
    else
      AmazonAudio.store(file)
      self.tap do |audio|
        audio.files = audio.files << AmazonAudio.url(file)
        audio.save
      end
    end
  end
end
