# encoding: utf-8
require 'amazon_audio'
class Audio < ActiveRecord::Base
  serialize :files, Array

  def self.upload(file)
    AmazonAudio.store(file)
  end

  def add_file!(file_url)
    update_attribute(:files, files << file_url)
  end

  def filenames
    files.collect { |url| url.split("/").last }
  end

  before_destroy do
    AmazonAudio.delete filenames
  end
end
