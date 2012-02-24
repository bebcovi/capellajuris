require 'unit/amazon/aws_s3_initializer'

module AmazonAudio
  include AWS::S3

  class << self
    def bucket_name
      "audio11"
    end

    def bucket
      AWS::S3::Bucket.find bucket_name
    end

    def objects
      bucket.objects :reload
    end

    def find(*files)
     files.flatten.each { |file| AWS::S3::S3Object.find(File.basename(file), bucket_name) }
    end
  end
end
