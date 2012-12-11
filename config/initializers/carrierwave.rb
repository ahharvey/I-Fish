AWS_CONFIG = YAML.load_file(Rails.root.join("config/credentials.yml"))[Rails.env]['aws']

CarrierWave.configure do |config|
  config.fog_directory  = AWS_CONFIG['directory']
  config.storage = :fog
  config.fog_credentials = {
      :provider => 'AWS',
      :aws_access_key_id => AWS_CONFIG['aws_access_key_id'],
      :aws_secret_access_key => AWS_CONFIG['aws_secret_access_key']
  }
end