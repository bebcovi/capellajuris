require 'aws/s3'
module AmazonAudio
  include AWS::S3

  def self.bucket_name
    "audio11"
  end

  def self.bucket
    Bucket.find(bucket_name)
  end

  def self.store(file)
    S3Object.store file.original_filename, file, bucket_name, :access => :public_read
    return url(file)
  end

  def self.exists?(file)
    S3Object.exists? file.original_filename, bucket_name
  end

  def self.url(file)
    "http://s3.amazonaws.com/#{bucket_name}/#{file.original_filename}"
  end

  def self.delete(*filenames)
    filenames.flatten.each { |filename| S3Object.delete(filename, bucket_name) }
  end
end
