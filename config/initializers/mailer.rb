ActionMailer::Base.raise_delivery_errors = true

ActionMailer::Base.smtp_settings = {
#  address: "smtp.gmail.com",
#  port: "587",
#  domain: "gmail.com",
#  authentication: :plain,
#  user_name: "noreplymessage124@gmail.com",
#  password: 'importexport123',
#  enable_starttls_auto: true
  :address   => "smtp.mandrillapp.com",
  :port      => 25, # ports 587 and 2525 are also supported with STARTTLS
  :enable_starttls_auto => true, # detects and uses STARTTLS
  :user_name => "mandrill@mantawatch.com",
  :password  => "Ti9wlU__9LmKrfsqonViEg", # SMTP password is any valid API key
  :authentication => 'login', # Mandrill supports 'plain' or 'login'
  :domain => 'yourdomain.com' # your domain to identify your server when connecting
}


