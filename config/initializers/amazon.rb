require "aws/s3"

amazon = CapellaJuris::Application.config.amazon
AWS::S3::Base.establish_connection! \
  :access_key_id => amazon[:access_key],
  :secret_access_key => amazon[:access_secret]
