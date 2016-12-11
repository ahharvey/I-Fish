ActionMailer::Base.raise_delivery_errors = true

ActionMailer::Base.smtp_settings = {
  user_name: ENV.fetch("SMTP_USERNAME"),
  password: ENV.fetch("SMTP_PASSWORD"), # SMTP password is any valid API key
  address: ENV.fetch("SMTP_ADDRESS"),
  domain: ENV.fetch("SMTP_DOMAIN"), # your domain to identify your server when connecting
  authentication: :login, # Mandrill supports 'plain' or 'login'
  enable_starttls_auto: true, # detects and uses STARTTLS
  port: "587"  # ports 25 and 2525 are also supported with STARTTLS
}
