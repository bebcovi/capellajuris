# encoding: utf-8
class Audio < ActiveRecord::Base
  mount_uploader :aac, AudioUploader
  mount_uploader :ogg, AudioUploader

  validates_presence_of :title, :message => "Naslov ne smije biti prazan."
  validates_uniqueness_of :title, :message => "Već postoji pjesma pod imenom \"%{value}\"."
  validates_presence_of :aac, :message => "AAC datoteka nije učitana."
  validates_presence_of :ogg, :message => "Ogg datoteka nije učitana."
  validate :uploaded_files_must_have_correct_formats
  validate :uploaded_files_must_be_unique

  def uploaded_files_must_have_correct_formats
    if aac.present? and aac.identifier !~ /\.aac$/i
      errors[:aac] << "\"#{aac.identifier}\" nije <strong>.aac</strong> datoteka."
    end
    if ogg.present? and ogg.identifier !~ /\.ogg/i
      errors[:ogg] << "\"#{ogg.identifier}\" nije <strong>.ogg</strong> datoteka."
    end
  end

  def uploaded_files_must_be_unique
    if aac.present? and aac.identifier.in?(Audio.pluck(:aac))
      errors[:aac] << "Već postoji AAC datoteka pod tim imenom. (#{aac.identifier})"
    end
    if ogg.present? and ogg.identifier.in?(Audio.pluck(:ogg))
      errors[:ogg] << "Već postoji Ogg datoteka pod tim imenom. (#{ogg.identifier})"
    end
  end

  def filenames
    [aac, ogg].map { |file| file.identifier || file.to_s.split("/").last }
  end

  def files
    [aac, ogg].map(&:url)
  end
end
