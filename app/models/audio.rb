class Audio < ActiveRecord::Base
  validates_uniqueness_of :filename
  validate :audio_files_must_exist_on_the_disk

  def audio_files_must_exist_on_the_disk
    if not files.present?
      errors[:filename] << "Pjesme s tim filenameom ne postoje na disku"
    end
  end

  def files_with_paths
    Dir["public/audios/#{filename}.*"]
  end

  def files
    files_with_paths.collect { |path_to_file| File.basename(path_to_file) }
  end

  before_destroy do
    File.delete *files_with_paths
  end
end
