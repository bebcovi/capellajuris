amazon = CapellaJuris::Application.config.amazon

CarrierWave.configure do |config|
  config.fog_credentials = {
    :provider => "AWS",
    :aws_access_key_id => amazon.access_key_id,
    :aws_secret_access_key => amazon.secret_access_key
  }
  config.fog_directory = "audio11"
end
