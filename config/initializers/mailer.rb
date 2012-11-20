ActionMailer::Base.smtp_settings = {
  address: "smtp.gmail.com",
  port: "587",
  domain: "gmail.com",
  authentication: :plain,
  user_name: "fajarrizki7@gmail.com",
  password: 'fajarrizki7',
  enable_starttls_auto: true
}
