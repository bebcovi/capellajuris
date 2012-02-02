require "aws/s3"

amazon = YAML.load(File.open("config/amazon.yml")).symbolize_keys
AWS::S3::Base.establish_connection! \
  :access_key_id => amazon[:access_key],
  :secret_access_key => amazon[:access_secret]
