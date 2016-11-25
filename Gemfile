source 'https://rubygems.org'
ruby "2.3.3"

##
## STACK
gem 'rails', '~> 4.2.0' #3.2.11'
gem 'pg', '~> 0.19.0'
#gem 'unicorn', '~> 4.8.0'
gem 'puma', '~> 3.6.0'
gem 'rack-timeout', '~> 0.4.0'
gem 'hirefire-resource', '~> 0.3.5'

##
## MODELS
gem 'paper_trail', '~> 5.2.0'
gem 'draftsman', '~> 0.6.0'
#gem 'queue_classic', '~>2.1.2' #queued processes
gem 'sidekiq', '~> 4.2.0'
gem 'validates_timeliness', '~> 4.0.0'
gem 'chronic', '~> 0.10.2'

##
## CONTROLLERS
# gem 'inherited_resources', '~> 1.6.0'
gem 'responders', '2.3.0'

##
## AUTHENTICATION
gem 'devise', '~> 4.2.0'
gem 'devise_invitable', '~> 1.7.0'
gem 'cancancan', '~> 1.15.0'
gem 'omniauth', '~> 1.3.0'
gem 'doorkeeper', '~> 4.2.0'
#gem 'oauth2'

##
## INCLUDES
gem 'jquery-rails', '~> 4.0.0'
gem 'jquery-ui-rails', '~> 5.0.0'
gem 'sass-rails',   '~> 5.0.0'
gem 'coffee-rails', '~> 4.1.0'
gem 'uglifier', '~> 3.0.0'


##
## CSS AND STYLING
gem 'bootstrap-sass', '~> 3.3.0'
gem 'font-awesome-sass', '~> 4.7.0'
gem 'simple_form', '~> 3.3.0'
gem 'kaminari', '~> 0.17.0'
gem 'rails4-autocomplete', '~> 1.1.1'
# gem 'bootstrap-switch-rails', '~> 1.8.1' #toggle buttons for Twitter Bootsterap

##
## UI
gem 'best_in_place', '~> 3.1.0' #in-line editing for logbooks and surveys
gem 'gmaps4rails', '~> 2.1.0'
gem 'local_time', '~> 1.0.0'
gem 'country_select', '~> 2.5.0'
gem 'countries', '~> 1.2.0'
gem 'modernizr-rails', '~> 2.7.0'
gem 'groupdate', '~> 3.1.1' # formats data for charts
gem 'chartkick', '~> 2.1.0' # adds ChartKick
#gem 'jquery-datatables-rails', '~> 1.12.1'

##
## DOWNLOADS AND OUTGOING
# gem 'wicked_pdf', '~> 0.11.0'
# gem 'wkhtmltopdf-heroku', '~> 2.12.0'
gem 'rabl', '~> 0.13.0' # JSON templates
gem 'oj', '~> 2.17.0' #high performance JSON parser for rabl
gem 'unf', '~> 0.1.3' #Unicode support required by Fog
gem 'rqrcode-with-patches', '~>0.6.0'
gem 'prawn', '~> 2.1.0'
#gem 'prawn-labels', '~> 1.2.3'
gem 'prawn-qrcode', '~> 0.2.2.1'

##
## UPLOADS AND INCOMING
gem 'carrierwave', '~> 0.11.0'
gem 'carrierwave_direct', '~> 0.0.15'
gem 'fog', '~> 1.38.0'
gem 'roo', '~> 2.0.0'
gem 'roo-xls', '~> 1.0.0'
gem 'mini_magick', '~> 4.5.0'
#gem 'rmagick', '~> 2.15.0'
gem 'griddler', '~> 1.3.0'  #Mandril API for incoming email handling
gem 'griddler-mandrill', '~> 1.1.0'
gem 'rubyzip', '~> 1.1.0'
# gem 'zip-zip', '~> 0.2'


gem 'whenever', '~> 0.9.4'


gem 'sinatra', require: nil


# gem 'axlsx_rails', '~> 0.2.0'
#gem 'rinruby', '~> 2.0.3'








group :production, :staging do
  # Heroku integration has previously relied on using the Rails plugin system,
  # which has been removed from Rails 4. To enable features such as static asset
  # serving and logging on Heroku please add rails_12factor gem to your Gemfile
  gem 'rails_12factor'
  # use NewRelic for system monitoring and profiling
  gem 'newrelic_rpm', '~> 3.17.0' #system monitoring and profiling
end




group :development, :test do
  # annotes models
  gem 'annotate'

  # Preview mail in the browser instead of sending
  gem 'letter_opener', '~> 1.4.0'

  # Tests ActionMailer and Mailer messages with Capybara
  # consider replacing with email_spec https://github.com/email-spec/email-spec
  gem 'capybara-email'

  # turns off the Rails asset pipeline log
  gem 'quiet_assets'

  # Call 'byebug' anywhere in the code to stop execution and get a debugger console
  gem 'byebug'

  # replaces the standard Rails error page
  gem 'better_errors'

  # Supporting gem for Rails Panel (Google Chrome extension for Rails development).
  # This may be able to be removed
  gem 'meta_request'

  # Improvements for Ruby's IRB console
  # works best with binding_of_caller
  # consider evlauating and deleting if not needed
  gem 'irbtools', require: false
  #gem 'binding_of_caller'
  # improves irb’s default inspect output
  gem 'hirb', '~> 0.7.1'

  # Spring speeds up development by keeping your application running in the background. Read more: https://github.com/rails/spring
  gem 'spring'

  # adds rspec testing
  gem 'rspec-rails', '~> 3.5.0'

  # adds guard for file change monitoring and integrates with the environment
  gem 'guard'
  gem 'terminal-notifier-guard'
  gem 'guard-spring', '~> 1.1', '>= 1.1.1'
  gem 'guard-brakeman'
  gem 'guard-rspec'
  # gem 'guard-rails_best_practices', github: 'logankoester/guard-rails_best_practices'

  # scans for security vulnerabilities
  gem 'brakeman', :require => false
  # watches for N+1 queries and suggests where eager loading should be added
  gem 'bullet'
  # code coverage analysis tool
  gem 'simplecov', :require => false

  # a code metric tool for rails projects
  gem 'rails_best_practices'

  gem 'rubocop'
end

group :test do
  # sets up Ruby objects as test data.
  gem 'factory_girl_rails'
  # Acceptance test framework for web applications
  gem 'capybara'
  # strategies for cleaning databases to ensure a clean state for testing.
  gem 'database_cleaner'
  # generates fake data such as names, addresses, and phone numbers.
  gem 'faker', '~> 1.6.0'
  # current version of shoulda-matchers, and it adds the 'respond_with_content_type' matcher back in
  gem "shoulda-kept-respond-with-content-type"
end
