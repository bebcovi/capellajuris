# encoding: utf-8
require 'amazon_audio'
class Audio < ActiveRecord::Base
  serialize :files, Array
  attr_accessor :file

  validates_presence_of :title, :message => "Naslov pjesme ne smije biti prazan"
  validates_presence_of :file, :message => "Audio datoteka nije učitana"
  validate :uniqueness_of_filename_on_amazon

  def uniqueness_of_filename_on_amazon
    if file.present? and AmazonAudio.exists?(file)
      errors[:file] << "Audio snimka s tim imenom datoteke već postoji (#{file.original_filename})"
    end
  end

  def add_file(file)
    AmazonAudio.store(file)
    update_attribute(:files, files << AmazonAudio.url(file))
  end

  def filenames
    files.collect { |url| url.match(/[^\/]+$/)[0] }
  end

  before_destroy do
    AmazonAudio.delete filenames
  end
end
