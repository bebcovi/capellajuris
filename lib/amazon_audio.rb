require 'aws/s3'
module AmazonAudio
  include AWS::S3

  def self.bucket
    @@bucket ||= Bucket.find("audio11")
  end

  def self.store(file)
    S3Object.store file.original_filename, file,
      bucket.name, :access => :public_read
  end

  def self.exists?(file)
    S3Object.exists? file.original_filename, bucket.name
  end

  def self.url(file)
    "http://s3.amazonaws.com/#{bucket.name}/#{file.original_filename}"
  end

  def self.delete(*filenames)
    filenames.flatten.each { |filename| S3Object.delete(filename, bucket.name) }
  end
end
