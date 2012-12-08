#to use aws s3 create file in /config/aws.yml
#
#development:
#aws_access_key_id: "xxxxxxxxxxxxxx"
#aws_secret_access_key: "xxxxxxxxxxxxxx"
#directory : 'xxxxxxxxxxxxxx'
#
#production:
#aws_access_key_id: "xxxxxxxxxxxxxx"
#aws_secret_access_key: "xxxxxxxxxxxxxx"
#directory : 'xxxxxxxxxxxxxx'

AWS_CONFIG = YAML.load_file(Rails.root.join("config/aws.yml"))[Rails.env]

CarrierWave.configure do |config|
  config.fog_directory  = AWS_CONFIG['directory']
  config.storage = :fog
  config.fog_credentials = {
      :provider => 'AWS',
      :aws_access_key_id => AWS_CONFIG['aws_access_key_id'],
      :aws_secret_access_key => AWS_CONFIG['aws_secret_access_key']
  }
end