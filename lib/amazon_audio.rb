require 'aws/s3'
module AmazonAudio
  class << self
    include AWS::S3

    def bucket_name
      "audio11"
    end

    def bucket
      Bucket.find(bucket_name)
    end

    def create(file)
      S3Object.store(file.original_filename, file, bucket_name, :access => :public_read)
    end

    def files
      bucket.objects(:reload)
    end

    def exists?(filename)
      S3Object.exists? filename, bucket_name
    end

    def url(file)
      "http://s3.amazonaws.com/#{bucket_name}/#{file.original_filename}"
    end

    def delete(filenames)
      filenames.each { |filename| S3Object.delete(filename, bucket_name) }
    end
  end
end
