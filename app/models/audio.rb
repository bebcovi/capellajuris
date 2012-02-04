# encoding: utf-8
require 'amazon_audio'
class Audio < ActiveRecord::Base
  validates_presence_of :title, :message => "Naslov ne smije biti prazan."
  validates_uniqueness_of :title, :message => "Već postoji pjesma pod tim naslovom."
  validates_presence_of :aac, :message => "AAC format datoteteke nije učitan."
  validates_presence_of :ogg, :message => "Ogg format datoteteke nije učitan."
  validate :filenames_must_be_unique_on_amazon
  validate :filenames_must_be_of_a_proper_format

  def filenames_must_be_unique_on_amazon
    if aac.present? and AmazonAudio.exists?(aac.original_filename)
      errors[:aac] << "Već postoji AAC datoteka pod tim imenom. (#{aac.original_filename})"
    end
    if ogg.present? and AmazonAudio.exists?(ogg.original_filename)
      errors[:ogg] << "Već postoji Ogg datoteka pod tim imenom. (#{ogg.original_filename})"
    end
  end

  def filenames_must_be_of_a_proper_format
    if aac.split(".").last != "aac"
      errors[:aac] << "AAC datoteka nije oblika 'ime_datoteke.aac'. (#{aac.original_filename})"
    end
    if ogg.split(".").last != "ogg"
      errors[:ogg] << "Ogg datoteka nije oblika 'ime_datoteke.ogg'. (#{ogg.original_filename})"
    end
  end

  before_create do
    unless aac.is_a?(String) and ogg.is_a?(String)
      AmazonAudio.create(aac)
      AmazonAudio.create(ogg)
      self.aac = aac.original_filename
      self.ogg = ogg.original_filename
    end
  end

  def filenames
    [aac, ogg]
  end

  def files
    filenames.collect { |filename| AmazonAudio.url(filename) }
  end

  before_destroy do
    AmazonAudio.delete filenames
  end
end
