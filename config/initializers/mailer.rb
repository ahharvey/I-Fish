ActionMailer::Base.raise_delivery_errors = true

ActionMailer::Base.smtp_settings = {
  address: "smtp.gmail.com",
  port: "587",
  domain: "gmail.com",
  authentication: :plain,
  user_name: "noreplymessage124@gmail.com",
  password: 'importexport123',
  enable_starttls_auto: true
}
