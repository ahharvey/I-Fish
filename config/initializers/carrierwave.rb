#if Rails.env.development?
#	AWS_CONFIG = YAML.load_file(Rails.root.join("config/credentials.yml"))[Rails.env]['aws']
#	AWS_KEY = AWS_CONFIG['aws_access_key_id']
#	AWS_SECRET = AWS_CONFIG['aws_secret_access_key']
#	AWS_DIRECTORY = AWS_CONFIG['directory']
#else
	AWS_KEY = ENV.fetch('S3_KEY')
	AWS_SECRET = ENV.fetch('S3_SECRET')
	AWS_DIRECTORY = ENV.fetch('S3_directory')
#end


CarrierWave.configure do |config|
  config.root = Rails.root.join('tmp')
  if Rails.env.development? || Rails.env.test?
    config.storage = :file
  else
    config.storage = :fog
  end
  config.fog_directory  = AWS_DIRECTORY

  config.fog_credentials = {
      :provider => 'AWS',
      :aws_access_key_id => AWS_KEY,
      :aws_secret_access_key => AWS_SECRET
  }
end
